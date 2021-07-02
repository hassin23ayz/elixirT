# A test file must reside in the test folder and its name must end with _test.exs
# .exs extension stands for Elixir script

# the script file must define the test module that contains the tests
defmodule Ch07_01TodoTest do
  # the testing framework for elixir is called ex_unit
  use ExUnit.Case
  doctest Todo.Cache

  # the test macro is an example of metaprogramming capabilities in elixir
  test "start()" do
    # assert macro takes an expression and verifies it outcome
    {result, _} = Todo.Cache.start()
    assert :ok == result
  end

  # test "todo operations" do
  #   {result, cache} = Todo.Cache.start()
  #   user1 = Todo.Cache.add_elem("alice")

  # end
end
