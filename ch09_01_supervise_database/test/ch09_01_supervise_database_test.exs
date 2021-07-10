defmodule Ch09_01SuperviseDatabaseTest do
  use ExUnit.Case
  doctest Ch09_01SuperviseDatabase

  test "greets the world" do
    assert Ch09_01SuperviseDatabase.hello() == :world
  end
end
