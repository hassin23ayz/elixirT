defmodule Ch08_01SupervisedTodoCacheTest do
  use ExUnit.Case
  doctest Ch08_01SupervisedTodoCache

  test "greets the world" do
    assert Ch08_01SupervisedTodoCache.hello() == :world
  end
end
