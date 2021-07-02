defmodule Ch07_02TodoPersistableTest do
  use ExUnit.Case
  doctest Ch07_02TodoPersistable

  test "greets the world" do
    assert Ch07_02TodoPersistable.hello() == :world
  end
end
