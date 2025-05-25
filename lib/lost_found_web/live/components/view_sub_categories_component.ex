defmodule LostFoundWeb.ViewSubCategoriesComponent do
  use LostFoundWeb, :live_component
  alias LostFound.CATEGORIES

  def update(assigns, socket) do
    if assigns.sub_categories == [] do
      socket = socket
      |> assign(:sub_categories, [])
      {:ok, socket}
    else
    sub_categories = for sub_category <- assigns.sub_categories do
      category = CATEGORIES.get_category!(sub_category.category_id)
      category = Map.from_struct(category)
      Map.put(sub_category, :category_name, category.name)
    end
    socket = socket
    |> assign(:sub_categories, sub_categories)
    {:ok, socket}
    end
  end

  def render(assigns) do
   ~H"""


<div class="relative overflow-x-auto">
    <button phx-click="close_view_sub_categories">
<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
</svg>

    </button>
    <table class="w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
            <tr>
                <th scope="col" class="px-6 py-3">
                 Category Name 
                </th>
                <th scope="col" class="px-6 py-3">
                 Sub category name 
                </th>
            </tr>
        </thead>
        <tbody>
          <%= for sub_category <- @sub_categories do %>
            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 border-gray-200">
                <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                 <%= sub_category.category_name %> 
                </th>
                <td class="px-6 py-4">
                  <%= sub_category.name %> 
                </td>
            </tr>
          <% end %>
      </tbody>
    </table>
</div>

   """
  end

end
