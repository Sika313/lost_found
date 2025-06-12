defmodule LostFoundWeb.ViewItemsComponent do
  use LostFoundWeb, :live_component
  alias LostFound.ITEMS
  alias LostFound.CATEGORIES
  alias LostFound.SUB_CATEGORIES

  def update(assigns, socket) do
    items = ITEMS.list_items()
    |> then(fn items -> for item <- items do Map.from_struct(item) end end)
   {:ok, socket}
   items_one = for item <- items do
    category = CATEGORIES.get_category!(item.category_id)
    Map.put(item, :category, category.name)
   end
   items_two = for item <- items_one do
    sub_category = SUB_CATEGORIES.get_sub_category!(item.sub_category_id)
    Map.put(item, :sub_category, sub_category.name)
   end
    socket = socket
    |> assign(:items, items_two)
    |> assign(:image, assigns.view_image)
    |> assign(:found_id, assigns.found_id)
    {:ok, socket}
  end

  def render(assigns) do
   ~H"""


<div class="relative overflow-x-auto">
    <button phx-click="close_view_items">
<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
  <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
</svg>

    </button>
    <%= if @items == [] do %>
      <h1>No items found.</h1>
    <% else %>
    <table class="overflow-scroll w-full text-sm text-left rtl:text-right text-gray-500 dark:text-gray-400">
        <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
            <tr>
              <th scope="col" class="px-6 py-3">
                 Category 
                </th>
              <th scope="col" class="px-6 py-3">
                 Sub category 
                </th>
                <th scope="col" class="px-6 py-3">
                 Item Code 
                </th>
                <th scope="col" class="px-6 py-3">
                  Description 
                </th>

                <th scope="col" class="px-6 py-3">
                  Location 
                </th>
                <th scope="col" class="px-6 py-3">
                  Status 
                </th>
                <th scope="col" class="px-6 py-3">
                  Brought by 
                </th>
                <th scope="col" class="px-6 py-3">
                  Date submitted 
                </th>

                <th scope="col" class="px-6 py-3">
                  Received by 
                </th>

            </tr>
        </thead>
        <tbody>
          <%= for item <- @items do %>
            <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700 border-gray-200">
                <th scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white">
                 <%= item.category %> 
                </th>
                <td class="px-6 py-4">
                  <%= item.sub_category %> 
                </td>
                <td class="px-6 py-4">
                  <%= item.code %> 
                </td>
                <td class="px-6 py-4">
                  <%= item.description %>  
                </td>
                <td class="px-6 py-4">
                  <%= item.location %>  
                </td>
                <td class="px-6 py-4">
                  <%= item.status %>  
                </td>
                <td class="px-6 py-4">
                  <%= item.brought_by %>  
                </td>
                <td class="px-6 py-4">
                  <%= item.inserted_at %>  
                </td>

                <td class="px-6 py-4">
                  <%= item.received_by %>  
                </td>
                <td class="px-6 py-4">
                <form phx-submit="handle_view_image">
                <input type="text" name="image" value={item.img_path} class="hidden" />
                  <button type="submit" phx-click={show_modal("view_image")} class="bg-blue-600 text-white px-2">View image</button>
                  </form>
              </td>
                <%= if item.status != "FOUND" do %>
                 <td class="px-6 py-4">
                <form phx-submit="found">
                <input type="text" name="found_id" value={item.id} class="hidden" />
                  <button type="submit" phx-click={show_modal("found")} class="bg-blue-600 text-white p-2">Found</button>
                  </form>
                </td>
                <% end %>
                 <%= if item.status != "FOUND" do %>
                 <td class="px-6 py-4">
                <form phx-submit="edit">
                <input type="text" name="found_id" value={item.id} class="hidden" />
                  <button type="submit" phx-click={show_modal("edit")} class="bg-blue-600 text-white p-2">Edit</button>
                  </form>
                </td>
                <% end %>
 
            </tr>
          <% end %>
      </tbody>
    </table>
    <% end %>
    
    <.modal id="view_image">
      <img src={"/images/uploads/" <> @image} class="w-60 h-60 rounded-md" />
    </.modal>

    <.modal id="found">
      <form phx-submit="handle_found">
        <label for="received_by">Received by</label>
        <input type="text" id="received_by" name="received_by" placeholder="Received by" />
      
      <button type="submit" phx-click={hide_modal("found")} class="bg-blue-600 text-white p-2">Found</button>

      </form>
    </.modal>

</div>

   """
  end
end
