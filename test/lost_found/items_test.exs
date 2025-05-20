defmodule LostFound.ITEMSTest do
  use LostFound.DataCase

  alias LostFound.ITEMS

  describe "items" do
    alias LostFound.ITEMS.Item

    import LostFound.ITEMSFixtures

    @invalid_attrs %{code: nil, description: nil, img_path: nil, location: nil, status: nil}

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert ITEMS.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert ITEMS.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      valid_attrs = %{code: "some code", description: "some description", img_path: "some img_path", location: "some location", status: "some status"}

      assert {:ok, %Item{} = item} = ITEMS.create_item(valid_attrs)
      assert item.code == "some code"
      assert item.description == "some description"
      assert item.img_path == "some img_path"
      assert item.location == "some location"
      assert item.status == "some status"
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ITEMS.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      update_attrs = %{code: "some updated code", description: "some updated description", img_path: "some updated img_path", location: "some updated location", status: "some updated status"}

      assert {:ok, %Item{} = item} = ITEMS.update_item(item, update_attrs)
      assert item.code == "some updated code"
      assert item.description == "some updated description"
      assert item.img_path == "some updated img_path"
      assert item.location == "some updated location"
      assert item.status == "some updated status"
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = ITEMS.update_item(item, @invalid_attrs)
      assert item == ITEMS.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = ITEMS.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> ITEMS.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = ITEMS.change_item(item)
    end
  end
end
