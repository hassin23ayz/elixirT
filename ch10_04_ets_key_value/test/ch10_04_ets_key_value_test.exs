defmodule Ch10_04EtsKeyValueTest do
  use ExUnit.Case
  doctest Ch10_04EtsKeyValue

  test "greets the world" do
    assert Ch10_04EtsKeyValue.hello() == :world
  end
end
