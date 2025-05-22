defmodule LostFoundWeb.PageController do
  use LostFoundWeb, :controller
  alias LostFound.USERS
  import Phoenix.LiveView.Controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def login(conn, _params) do
    render(conn, :login)
  end


  def handle_login(conn, params) do
    IO.inspect(params)
    case USERS.find_by_phone_and_password(params) do
    {:error} ->
      conn = conn
      |> put_flash(:error, "User not found")
      |> redirect(to: "/")
      conn
    {:ok, result} ->
      r = Map.from_struct(result)
      conn
      |> put_flash(:info, "Logged in successfully.")
      |> put_session(:id, r.id)
      |> live_render(LostFoundWeb.AdminLive) 
    end
  end

  def logout(conn, _params) do
    conn = conn
    |> clear_session()
    |> put_flash(:info, "Successfully logged out.")
    |> redirect(to: "/")
    conn
  end

end
