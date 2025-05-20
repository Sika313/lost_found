defmodule LostFound.ROLESFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LostFound.ROLES` context.
  """

  @doc """
  Generate a role.
  """
  def role_fixture(attrs \\ %{}) do
    {:ok, role} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> LostFound.ROLES.create_role()

    role
  end
end
