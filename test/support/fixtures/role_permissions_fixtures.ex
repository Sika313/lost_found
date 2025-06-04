defmodule LostFound.ROLE_PERMISSIONSFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LostFound.ROLE_PERMISSIONS` context.
  """

  @doc """
  Generate a role_permission.
  """
  def role_permission_fixture(attrs \\ %{}) do
    {:ok, role_permission} =
      attrs
      |> Enum.into(%{
        permissions: ["option1", "option2"]
      })
      |> LostFound.ROLE_PERMISSIONS.create_role_permission()

    role_permission
  end
end
