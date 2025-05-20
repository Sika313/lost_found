defmodule LostFound.ITEMS.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    belongs_to :category, Category, foreign_key: :category_id, type: :id
    field :code, :string
    field :description, :string
    field :img_path, :string
    field :location, :string
    field :status, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:code, :location, :description, :img_path, :status, :category_id])
    |> validate_required([:code, :location, :description, :img_path, :status, :category_id])
  end
end
