defmodule LostFound.ROLE_PERMISSIONSTest do
  use LostFound.DataCase

  alias LostFound.ROLE_PERMISSIONS

  describe "role_permissions" do
    alias LostFound.ROLE_PERMISSIONS.Role_permission

    import LostFound.ROLE_PERMISSIONSFixtures

    @invalid_attrs %{permissions: nil}

    test "list_role_permissions/0 returns all role_permissions" do
      role_permission = role_permission_fixture()
      assert ROLE_PERMISSIONS.list_role_permissions() == [role_permission]
    end

    test "get_role_permission!/1 returns the role_permission with given id" do
      role_permission = role_permission_fixture()
      assert ROLE_PERMISSIONS.get_role_permission!(role_permission.id) == role_permission
    end

    test "create_role_permission/1 with valid data creates a role_permission" do
      valid_attrs = %{permissions: ["option1", "option2"]}

      assert {:ok, %Role_permission{} = role_permission} = ROLE_PERMISSIONS.create_role_permission(valid_attrs)
      assert role_permission.permissions == ["option1", "option2"]
    end

    test "create_role_permission/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ROLE_PERMISSIONS.create_role_permission(@invalid_attrs)
    end

    test "update_role_permission/2 with valid data updates the role_permission" do
      role_permission = role_permission_fixture()
      update_attrs = %{permissions: ["option1"]}

      assert {:ok, %Role_permission{} = role_permission} = ROLE_PERMISSIONS.update_role_permission(role_permission, update_attrs)
      assert role_permission.permissions == ["option1"]
    end

    test "update_role_permission/2 with invalid data returns error changeset" do
      role_permission = role_permission_fixture()
      assert {:error, %Ecto.Changeset{}} = ROLE_PERMISSIONS.update_role_permission(role_permission, @invalid_attrs)
      assert role_permission == ROLE_PERMISSIONS.get_role_permission!(role_permission.id)
    end

    test "delete_role_permission/1 deletes the role_permission" do
      role_permission = role_permission_fixture()
      assert {:ok, %Role_permission{}} = ROLE_PERMISSIONS.delete_role_permission(role_permission)
      assert_raise Ecto.NoResultsError, fn -> ROLE_PERMISSIONS.get_role_permission!(role_permission.id) end
    end

    test "change_role_permission/1 returns a role_permission changeset" do
      role_permission = role_permission_fixture()
      assert %Ecto.Changeset{} = ROLE_PERMISSIONS.change_role_permission(role_permission)
    end
  end
end
