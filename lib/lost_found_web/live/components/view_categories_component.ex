defmodule LostFoundWeb.ViewCategoriesComponent do
  use LostFoundWeb, :live_component
  alias LostFoundWeb.CATEGORIES

  def update(assigns, socket) do
    socket = socket
    |> assign(:categories, assigns.categories)
    {:ok, socket}
  end

  def render(assigns) do
   ~H"""


<div class="relative overflow-x-auto">
    <button phx-click="close_view_categories">
<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
</svg>

    </button>
    <%= if @categories == [] do %>
      <h1>No categories found.</h1>
    <% else %>
    <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
            <tr>
                <th scope="col" class="px-6 py-3">
                 Name 
                </th>
           </tr>
        </thead>
        <tbody>
          <%= for category <- @categories do %>
            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 border-gray-200">
                <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                 <%= category.name %> 
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
