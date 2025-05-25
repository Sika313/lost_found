defmodule LostFound.SUB_CATEGORIESTest do
  use LostFound.DataCase

  alias LostFound.SUB_CATEGORIES

  describe "sub_categories" do
    alias LostFound.SUB_CATEGORIES.Sub_category

    import LostFound.SUB_CATEGORIESFixtures

    @invalid_attrs %{name: nil}

    test "list_sub_categories/0 returns all sub_categories" do
      sub_category = sub_category_fixture()
      assert SUB_CATEGORIES.list_sub_categories() == [sub_category]
    end

    test "get_sub_category!/1 returns the sub_category with given id" do
      sub_category = sub_category_fixture()
      assert SUB_CATEGORIES.get_sub_category!(sub_category.id) == sub_category
    end

    test "create_sub_category/1 with valid data creates a sub_category" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Sub_category{} = sub_category} = SUB_CATEGORIES.create_sub_category(valid_attrs)
      assert sub_category.name == "some name"
    end

    test "create_sub_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SUB_CATEGORIES.create_sub_category(@invalid_attrs)
    end

    test "update_sub_category/2 with valid data updates the sub_category" do
      sub_category = sub_category_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Sub_category{} = sub_category} = SUB_CATEGORIES.update_sub_category(sub_category, update_attrs)
      assert sub_category.name == "some updated name"
    end

    test "update_sub_category/2 with invalid data returns error changeset" do
      sub_category = sub_category_fixture()
      assert {:error, %Ecto.Changeset{}} = SUB_CATEGORIES.update_sub_category(sub_category, @invalid_attrs)
      assert sub_category == SUB_CATEGORIES.get_sub_category!(sub_category.id)
    end

    test "delete_sub_category/1 deletes the sub_category" do
      sub_category = sub_category_fixture()
      assert {:ok, %Sub_category{}} = SUB_CATEGORIES.delete_sub_category(sub_category)
      assert_raise Ecto.NoResultsError, fn -> SUB_CATEGORIES.get_sub_category!(sub_category.id) end
    end

    test "change_sub_category/1 returns a sub_category changeset" do
      sub_category = sub_category_fixture()
      assert %Ecto.Changeset{} = SUB_CATEGORIES.change_sub_category(sub_category)
    end
  end
end
