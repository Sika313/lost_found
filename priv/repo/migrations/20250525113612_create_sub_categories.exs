defmodule LostFound.Repo.Migrations.CreateSubCategories do
  use Ecto.Migration

  def change do
    create table(:sub_categories) do
      add :name, :string

      add :sub_category, references(:categories, column: :id, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end
  end
end
