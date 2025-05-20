defmodule LostFound.Repo do
  use Ecto.Repo,
    otp_app: :lost_found,
    adapter: Ecto.Adapters.Postgres
end
