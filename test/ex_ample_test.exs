defmodule ExAmpleTest do
  use ExUnit.Case
  doctest ExAmple

  test "greets the world" do
    assert ExAmple.hello() == :world
  end
end
