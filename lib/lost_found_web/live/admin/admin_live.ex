defmodule LostFoundWeb.AdminLive do
  use LostFoundWeb, :live_view
  alias LostFound.ROLES
  alias LostFound.USERS
  alias LostFound.CATEGORIES
  alias LostFound.SUB_CATEGORIES
  alias LostFound.PERMISSIONS
  alias LostFound.ROLE_PERMISSIONS
  alias LostFoundWeb.ViewRolesComponent
  alias LostFoundWeb.ViewUsersComponent
  alias LostFoundWeb.ViewCategoriesComponent
  alias LostFoundWeb.ViewSubCategoriesComponent

  def mount(_params, session, socket) do
    permissions = PERMISSIONS.list_permissions() 
    permissions_map = for permission <- permissions do
      Map.from_struct(permission)
    end
    categories = CATEGORIES.list_categories()
    categories = for category <- categories do
      Map.from_struct(category)
    end

    sub_categories = SUB_CATEGORIES.list_sub_categories()
    sub_categories = for sub_category <- sub_categories do
      Map.from_struct(sub_category)
    end
  
    roles = for role <- ROLES.list_roles() do
      Map.from_struct(role)
    end

    user = USERS.get_user!(session["id"]) |> Map.from_struct()
    socket = socket
    |> assign(:permissions, permissions_map)
    |> assign(:roles, roles)
    |> assign(:user, user)
    |> assign(:view_roles, false)
    |> assign(:view_users, false)
    |> assign(:categories, categories)
    |> assign(:sub_categories, sub_categories)
    |> assign(:view_categories, false)
    |> assign(:view_sub_categories, false)
    {:ok, socket}
  end

  def handle_event("close_view_roles", _params, socket) do
    socket = socket
    |> assign(:view_roles, false)
    {:noreply, socket}
  end
  def handle_event("close_view_users", _params, socket) do
    socket = socket
    |> assign(:view_users, false)
    {:noreply, socket}
  end
  def handle_event("close_view_categories", _params, socket) do
    socket = socket
    |> assign(:view_categories, false)
    {:noreply, socket}
  end
  def handle_event("close_view_sub_categories", _params, socket) do
    socket = socket
    |> assign(:view_sub_categories, false)
    {:noreply, socket}
  end

    def handle_event("handle_add_role", params, socket) do

    IO.inspect(params, label: "PARAMS--->")
    perm = Map.delete(params, "name")
    permissions = Map.delete(perm, "description")

    role = %{
      name: params["name"],
      description: params["description"]
    }
    ROLES.create_role(role)
    |> then(fn i -> add_role_permission(params["name"], permissions) end)
    roles = for role <- ROLES.list_roles() do
      Map.from_struct(role)
    end

    socket = socket
    |> assign(:roles, roles)
    |> put_flash(:info, "Role added successfully.")
    {:noreply, socket}
  end
  def add_role_permission(name, permissions) do
   role = ROLES.find_by_name(name) |> Map.from_struct() 
   permission_list = Map.values(permissions)
   role_permission = %{
    role_id: role.id,
    permissions: permission_list
   }
   permissions = ROLE_PERMISSIONS.create_role_permission(role_permission)
  end

  def handle_event("view_roles", _params, socket) do
    socket = socket
    |> assign(:view_roles, true)
    {:noreply, socket}
  end
  def handle_event("view_categories", _params, socket) do
    socket = socket
    |> assign(:view_categories, true)
    {:noreply, socket}
  end
  def handle_event("view_sub_categories", _params, socket) do
    socket = socket
    |> assign(:view_sub_categories, true)
    {:noreply, socket}
  end



  def handle_event("handle_add_user", params, socket) do
    user = %{
      fname: params["fname"],
      lname: params["lname"],
      gender: params["gender"],
      phone: params["phone"],
      password: params["password"],
      role_id: params["role_id"]
    }
    IO.inspect(user)
    USERS.create_user(user)

    user = USERS.get_user!(socket.assigns.user.id) |> Map.from_struct()
    socket = socket
    |> assign(:user, user)
    |> put_flash(:info, "User added successfully.")
    {:noreply, socket}
  end
  def handle_event("view_users", _params, socket) do
    socket = socket
    |> assign(:view_users, true)
    {:noreply, socket}
  end

  def handle_event("handle_add_category", params, socket) do
    category = %{name: params["name"]}
    CATEGORIES.create_category(category)

    categories = CATEGORIES.list_categories()
    categories = for category <- categories do
      Map.from_struct(category)
    end
    socket = socket
    |> assign(:categories, categories)
    |> put_flash(:info, "Category successfully added")
    {:noreply, socket}
  end

  def handle_event("handle_add_sub_category", params, socket) do
    IO.inspect(params, label: "PARAMS--->")
    sub_category = %{
      name: params["name"],
      category_id: String.to_integer(params["category_id"])
    }
    SUB_CATEGORIES.create_sub_category(sub_category)

    sub_categories = SUB_CATEGORIES.list_sub_categories()
    sub_categories = for sub_category <- sub_categories do
      Map.from_struct(sub_category)
    end
  
    socket = socket
    |> assign(:sub_categories, sub_categories)
    |> put_flash(:info, "Sub category added successfully.")
    {:noreply, socket}
  end

end
