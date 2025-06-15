defmodule LostFoundWeb.AdminLive do
  use LostFoundWeb, :live_view

  alias LostFound.ITEMS
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
  alias LostFoundWeb.ViewItemsComponent
  alias LostFoundWeb.ViewCustomerReportsComponent

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
    user_permissions = ROLE_PERMISSIONS.get_by_role_id(user.role_id) |> Map.from_struct()
    socket = socket
    |> assign(:permissions, permissions_map)
    |> assign(:user_permissions, user_permissions.permissions)
    |> assign(:roles, roles)
    |> assign(:user, user)
    |> assign(:view_roles, false)
    |> assign(:view_users, false)
    |> assign(:categories, categories)
    |> assign(:sub_categories, sub_categories)
    |> assign(:view_categories, false)
    |> assign(:view_sub_categories, false)
    |> assign(:view_items, false)
    |> assign(:view_image, " ")
    |> assign(:view_customer_reports, false)
    |> assign(:item, %{
      description: " ",
      location: " ",
      brought_by: " ",
    })
    |> assign(:found_id, " ")
    |> assign(:uploaded_files, [])
    |> allow_upload(:avatar, accept: ~w(.jpg), max_entries: 2)
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
  def handle_event("close_view_items", _params, socket) do
    socket = socket
    |> assign(:view_items, false)
    {:noreply, socket}
  end
  def handle_event("close_view_customer_reports", _params, socket) do
    socket = socket
    |> assign(:view_customer_reports, false)
    {:noreply, socket}
  end


    def handle_event("handle_add_role", params, socket) do
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
    |> assign(:view_users, false)
    |> assign(:view_categories, false)
    |> assign(:view_sub_categories, false)
    |> assign(:view_items, false)
    |> assign(:view_customer_reports, false)
    {:noreply, socket}
  end
def handle_event("view_users", _params, socket) do
    socket = socket
    |> assign(:view_roles, false)
    |> assign(:view_users, true)
    |> assign(:view_categories, false)
    |> assign(:view_sub_categories, false)
    |> assign(:view_items, false)

    |> assign(:view_customer_reports, false)
    {:noreply, socket}
  end


  def handle_event("view_categories", _params, socket) do
    socket = socket
    |> assign(:view_roles, false)
    |> assign(:view_users, false)
    |> assign(:view_categories, true)
    |> assign(:view_sub_categories, false)
    |> assign(:view_items, false)
    |> assign(:view_customer_reports, false)
    {:noreply, socket}
  end
  def handle_event("view_sub_categories", _params, socket) do
    socket = socket
    |> assign(:view_roles, false)
    |> assign(:view_users, false)
    |> assign(:view_categories, false)
    |> assign(:view_sub_categories, true)
    |> assign(:view_items, false)
    |> assign(:view_customer_reports, false)
    {:noreply, socket}
  end
  def handle_event("view_items", _params, socket) do
    socket = socket
    |> assign(:view_roles, false)
    |> assign(:view_users, false)
    |> assign(:view_categories, false)
    |> assign(:view_sub_categories, false)
    |> assign(:view_items, true)
    |> assign(:view_customer_reports, false)
    {:noreply, socket}
  end
  def handle_event("view_customer_reports", _params, socket) do
    socket = socket
    |> assign(:view_roles, false)
    |> assign(:view_users, false)
    |> assign(:view_categories, false)
    |> assign(:view_sub_categories, false)
    |> assign(:view_items, false)
    |> assign(:view_customer_reports, true)
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
    USERS.create_user(user)

    user = USERS.get_user!(socket.assigns.user.id) |> Map.from_struct()
    socket = socket
    |> assign(:user, user)
    |> put_flash(:info, "User added successfully.")
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


  def handle_event("save", params, socket) do
  IO.inspect(params, label: "PARAMS--->")
  uploaded_files =
    consume_uploaded_entries(socket, :avatar, fn %{path: path}, _entry ->
      dest = Path.join(Application.app_dir(:lost_found, "priv/static/images/uploads"), Path.basename(path))
      # You will need to create `priv/static/uploads` for `File.cp!/2` to work.
      File.cp!(path, dest <> ".jpg")
      file_name = String.splitter(dest, "/") |> Enum.take(-1)
      full_file_name = Enum.at(file_name, 0) <> ".jpg"


      uploads = %{
      category_id: params["category_id"],
      sub_category_id: params["sub_category_id"],
      code: UUID.uuid4(),
      description: params["description"],
      img_path: full_file_name,
      location: params["location"],
      status: "NOT FOUND",
      brought_by: params["brought_by"],
      received_by: "PENDING"
      }
      ITEMS.create_item(uploads)
     
      PROPERTIES.create_property(uploads)
      {:ok, ~p"/uploads/#{Path.basename(dest)}"}
    end)
    {:noreply, update(socket, :uploaded_files, &(&1 ++ uploaded_files))}
  end

  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end


  def handle_event("handle_view_image", params, socket) do
    IO.inspect(params, label: "SELF, PARAMS--->")
    socket = socket
    |> assign(:view_image, params["image"])
    {:noreply, socket}
  end

  def handle_event("found", params, socket) do
    socket = socket
    |> assign(:found_id, params["found_id"])
    {:noreply, socket}
  end

  def handle_event("edit", params, socket) do
    IO.inspect("HHHIIITTT--->")
    item = ITEMS.get_item!(String.to_integer(params["found_id"])) |> Map.from_struct() 
    IO.inspect(item, label: "ITEM--->")
    socket = socket
    |> assign(:found_id, params["found_id"])
    |> assign(:item, item)
    {:noreply, socket}
  end

  def handle_event("handle_found", params, socket) do
    item = ITEMS.get_item!(String.to_integer(socket.assigns.found_id))
    update = %{
      status: "FOUND",
      received_by: params["received_by"]
    }
    ITEMS.update_item(item, update)
    socket = socket
    |> put_flash(:info, "Item updated successfully.")
    {:noreply, socket}
  end

  def handle_event("handle_edit", params, socket) do
    IO.inspect(params, label: "EDIT PARAMS--->")
    item = ITEMS.get_item!(String.to_integer(params["found_id"])) 
    ITEMS.update_item(item, params)
    socket = socket
    |> put_flash(:info, "Item updated successfully.")
    {:noreply, socket}
  end

end
