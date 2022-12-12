defmodule ExAmple.Repo do
  use Ecto.Repo,
    otp_app: :ex_ample,
    adapter: Ecto.Adapters.Postgres

  def init(_type, config) do
    {:ok, Keyword.put(config, :url, System.fetch_env!("DATABASE_URL"))}
  end
end
