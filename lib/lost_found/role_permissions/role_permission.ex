defmodule LostFound.ROLE_PERMISSIONS.Role_permission do
  use Ecto.Schema
  import Ecto.Changeset

  schema "role_permissions" do
    belongs_to :role, Role, foreign_key: :role_id, type: :id
    field :permissions, {:array, :string}

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(role_permission, attrs) do
    role_permission
    |> cast(attrs, [:permissions, :role_id])
    |> validate_required([:permissions, :role_id])
  end
end
