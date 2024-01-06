defmodule ElixirGreatingTest do
  use ExUnit.Case
  doctest ElixirGreating

  test "greets the world" do
    assert ElixirGreating.hello() == :world
  end
end
