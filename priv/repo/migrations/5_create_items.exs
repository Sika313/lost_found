defmodule LostFound.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :code, :string
      add :location, :string
      add :description, :string
      add :img_path, :string
      add :status, :string
      add :brought_by, :string
      add :received_by, :string

      add :category_id, references(:categories, column: :id, on_delete: :nothing)
      add :sub_category_id, references(:sub_categories, column: :id, on_delete: :nothing)
      timestamps(type: :utc_datetime)
    end
  end
end
