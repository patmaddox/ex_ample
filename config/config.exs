import Config

config :ex_ample, :ecto_repos, [ExAmple.Repo]

import_config "#{Mix.env()}.exs"
