defmodule LostFound.PERMISSIONSFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LostFound.PERMISSIONS` context.
  """

  @doc """
  Generate a permission.
  """
  def permission_fixture(attrs \\ %{}) do
    {:ok, permission} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> LostFound.PERMISSIONS.create_permission()

    permission
  end
end
