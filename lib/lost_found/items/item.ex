defmodule LostFound.ITEMS.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    belongs_to :category, Category, foreign_key: :category_id, type: :id
    belongs_to :sub_category, Sub_category, foreign_key: :sub_category_id, type: :id
    field :code, :string
    field :description, :string
    field :img_path, :string
    field :location, :string
    field :status, :string
    field :brought_by, :string
    field :received_by, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:code, :location, :description, :img_path, :status, :category_id, :sub_category_id, :brought_by, :received_by])
    |> validate_required([:code, :location, :description, :img_path, :status, :category_id, :sub_category_id, :brought_by, :received_by])
  end
end
