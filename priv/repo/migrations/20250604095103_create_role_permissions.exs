defmodule LostFound.Repo.Migrations.CreateRolePermissions do
  use Ecto.Migration

  def change do
    create table(:role_permissions) do
      add :permissions, {:array, :string}

      add :role_id, references(:roles, column: :id, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end
  end
end
