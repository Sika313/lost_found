defmodule LostFound.ONLINE_REPORTS.Online_report do
  use Ecto.Schema
  import Ecto.Changeset

  schema "online_reports" do
    field :description, :string
    field :phone, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(online_report, attrs) do
    online_report
    |> cast(attrs, [:description, :phone])
    |> validate_required([:description, :phone])
  end
end
