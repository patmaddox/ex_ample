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
      build_id: System.fetch_env!("CIRRUS_BUILD_ID"),
      branch: System.fetch_env!("CIRRUS_BRANCH"),
      commit_short: commit_short(),
      port_version: port_version(),
      github_tag: github_tag(),
      port_name: port_name(),
      suffix: suffix()
    }
  end

  defp port_version do
    if is_release?() do
      base_version()
    else
      timestamp =
        DateTime.utc_now()
        |> DateTime.truncate(:second)
        |> DateTime.to_iso8601()
        |> String.replace(~r/\D/, "")

      "#{base_version()}p#{timestamp}"
    end
  end

  defp github_tag, do: System.fetch_env!("CIRRUS_CHANGE_IN_REPO")

  defp commit_short, do: github_tag() |> String.slice(0..9)

  defp port_name do
    {:ok, app} = Mix.Project.config() |> Keyword.fetch(:app)
    app
  end

  defp suffix do
    unless is_release?() do
      "-#{System.fetch_env!("CIRRUS_BRANCH")}"
    end
  end

  def base_version do
    {:ok, version} = Mix.Project.config() |> Keyword.fetch(:version)
    version
  end

  defp is_release? do
    case System.fetch_env("CIRRUS_TAG") do
      {:ok, version} -> version == "v#{base_version()}"
      _ -> false
    end
  end
end
