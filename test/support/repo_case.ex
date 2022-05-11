defmodule ExAmple.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias ExAmple.Repo

      import Ecto
      import Ecto.Query
      import ExAmple.RepoCase

      # and any other stuff
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(ExAmple.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(ExAmple.Repo, {:shared, self()})
    end

    :ok
  end
end
