defmodule LostFoundWeb.AdminLive do
  use LostFoundWeb, :live_view
  alias LostFound.ROLES
  alias LostFound.USERS
  alias LostFoundWeb.ViewRolesComponent
  alias LostFoundWeb.ViewUsersComponent

  def mount(_params, session, socket) do
    roles = for role <- ROLES.list_roles() do
      Map.from_struct(role)
    end

    user = USERS.get_user!(session["id"]) |> Map.from_struct()
    socket = socket
    |> assign(:roles, roles)
    |> assign(:user, user)
    |> assign(:view_roles, false)
    |> assign(:view_users, false)
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

    def handle_event("handle_add_role", params, socket) do
    role = %{
      name: params["name"],
      description: params["description"]
    }
    ROLES.create_role(role)
    roles = for role <- ROLES.list_roles() do
      Map.from_struct(role)
    end

    socket = socket
    |> assign(:roles, roles)
    |> put_flash(:info, "Role added successfully.")
    {:noreply, socket}
  end
  def handle_event("view_roles", _params, socket) do
    socket = socket
    |> assign(:view_roles, true)
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



end
