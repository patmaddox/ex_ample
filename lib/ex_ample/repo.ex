defmodule ExAmple.Repo do
  use Ecto.Repo,
    otp_app: :ex_ample,
    adapter: Ecto.Adapters.Postgres
end
