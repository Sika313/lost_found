defmodule LostFound.Repo.Migrations.CreateOnlineReports do
  use Ecto.Migration

  def change do
    create table(:online_reports) do
      add :description, :string
      add :phone, :string

      timestamps(type: :utc_datetime)
    end
  end
end
