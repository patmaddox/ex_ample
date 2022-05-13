defmodule Mix.Tasks.FreebsdPort do
  @moduledoc "Generate FreeBSD port files: `mix help freebsd_port`"

  use Mix.Task

  @shortdoc "Generates FreeBSD port files"
  def run(_) do
    result = EEx.eval_file("freebsd/Makefile.eex", assigns: assigns())
    File.write!("freebsd/Makefile", result)
    IO.puts("Wrote freebsd/Makefile")
  end

  defp assigns do
    %{
      github_tag: github_tag(),
      commit_short: github_tag() |> String.slice(0..9),
      dist_version: dist_version()
    }
  end

  defp github_tag, do: System.fetch_env!("CIRRUS_CHANGE_IN_REPO")

  defp dist_version do
    {:ok, base_version} = Mix.Project.config() |> Keyword.fetch(:version)
    build_id = System.fetch_env!("CIRRUS_BUILD_ID")
    "#{base_version}-b#{build_id}"
  end
end
