defmodule Ch07_01TodoTest do
  use ExUnit.Case
  doctest Ch07_01Todo

  test "greets the world" do
    assert Ch07_01Todo.hello() == :world
  end
end
