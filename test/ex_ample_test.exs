defmodule ExAmpleTest do
  use ExAmple.RepoCase
  doctest ExAmple

  alias ExAmple.Item
  alias ExAmple.Repo

  test "greets the world" do
    assert ExAmple.hello() == :world
  end

  test "create item" do
    assert {:ok, %Item{}} = %Item{name: "item name"} |> Repo.insert()
  end
end
