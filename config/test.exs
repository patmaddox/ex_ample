import Config

config :ex_ample, ExAmple.Repo,
  database: "ex_ample_test",
  username: "postgres",
  pool: Ecto.Adapters.SQL.Sandbox

# username: "user",
# password: "pass",
# hostname: "localhost"
