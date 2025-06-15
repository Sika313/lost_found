defmodule LostFoundWeb.ViewCustomerReportsComponent do
  use LostFoundWeb, :live_component
  alias LostFound.ONLINE_REPORTS

  def update(assigns, socket) do
    online_reports = ONLINE_REPORTS.list_online_reports()
    |> then(fn reports -> for report <- reports do Map.from_struct(report) end end)
    
    socket = socket
    |> assign(:reports, online_reports)
    {:ok, socket}
  end

  def render(assigns) do
   ~H"""


<div class="relative overflow-x-auto">
    <button phx-click="close_view_customer_reports">
<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
</svg>

    </button>
    <%= if @reports == [] do %>
      <h1>No reports found.</h1>
    <% else %>
    <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
            <tr>
                <th scope="col" class="px-6 py-3">
                 Description 
                </th>
               <th scope="col" class="px-6 py-3">
                 Customer phone number 
                </th>
               <th scope="col" class="px-6 py-3">
                 Reported at 
                </th>
           </tr>
        </thead>
        <tbody>
          <%= for report <- @reports do %>
            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 border-gray-200">
                <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                 <%= report.description %> 
                </th>
                <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                 <%= report.phone %> 
                </th>
                <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                 <%= report.inserted_at %> 
                </th>
           </tr>
          <% end %>

      </tbody>
    </table>

   <% end %>
</div>

   """
  end

end
