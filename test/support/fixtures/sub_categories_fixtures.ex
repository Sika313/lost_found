defmodule LostFound.SUB_CATEGORIESFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LostFound.SUB_CATEGORIES` context.
  """

  @doc """
  Generate a sub_category.
  """
  def sub_category_fixture(attrs \\ %{}) do
    {:ok, sub_category} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> LostFound.SUB_CATEGORIES.create_sub_category()

    sub_category
  end
end
