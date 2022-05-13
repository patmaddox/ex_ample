defmodule Mix.Tasks.FreebsdPort do
  @moduledoc "Generate FreeBSD port files: `mix help freebsd_port`"

  use Mix.Task

  @shortdoc "Generates FreeBSD port files"
  def run(_) do
    github_tag = System.fetch_env!("CIRRUS_CHANGE_IN_REPO")
    result = EEx.eval_file("freebsd/Makefile.eex", assigns: %{github_tag: github_tag})
    File.write!("freebsd/Makefile", result)
    IO.puts("Wrote freebsd/Makefile")
  end
end
