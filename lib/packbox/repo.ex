defmodule Packbox.Repo do
  use Ecto.Repo,
    otp_app: :packbox,
    adapter: Ecto.Adapters.Postgres
end
