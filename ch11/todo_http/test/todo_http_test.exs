defmodule TodoHttpTest do
  use ExUnit.Case
  doctest TodoHttp

  test "greets the world" do
    assert TodoHttp.hello() == :world
  end
end
