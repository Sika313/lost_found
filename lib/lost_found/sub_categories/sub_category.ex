defmodule LostFound.SUB_CATEGORIES.Sub_category do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sub_categories" do
    belongs_to :category, Category, foreign_key: :sub_category_id, type: :id
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(sub_category, attrs) do
    sub_category
    |> cast(attrs, [:name, :sub_category_id])
    |> validate_required([:name, :sub_category_id])
  end
end
