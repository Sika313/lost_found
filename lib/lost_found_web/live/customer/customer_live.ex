defmodule LostFoundWeb.CustomerLive do
  use LostFoundWeb, :live_view

  alias LostFound.ONLINE_REPORTS

  def mount(_params, session, socket) do
    {:ok, socket}
  end

  def handle_event("handle_online_report", params, socket) do
    report = %{
      description: params["description"],
      phone: params["phone"]
    }
    ONLINE_REPORTS.create_online_report(report)
    socket = socket
    |> put_flash(:info, "Item reported successfully.")
    |> redirect(to: "/")
    {:noreply, socket}
  end
end
