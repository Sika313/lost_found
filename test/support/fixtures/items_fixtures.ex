defmodule LostFound.ITEMSFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LostFound.ITEMS` context.
  """

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        code: "some code",
        description: "some description",
        img_path: "some img_path",
        location: "some location",
        status: "some status"
      })
      |> LostFound.ITEMS.create_item()

    item
  end
end
