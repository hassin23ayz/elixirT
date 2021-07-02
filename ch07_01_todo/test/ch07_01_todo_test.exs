# A test file must reside in the test folder and its name must end with _test.exs
# .exs extension stands for Elixir script

# the script file must define the test module that contains the tests
defmodule Ch07_01TodoTest do
  # the testing framework for elixir is called ex_unit
  use ExUnit.Case
  doctest Todo.Cache

  # the test macro is an example of metaprogramming capabilities in elixir
  # test "start()" do
  #   # assert macro takes an expression and verifies it outcome
  #   {result, _} = Todo.Cache.start()
  #   assert :ok == result
  # end

  test "todo operations" do
    # create a Cache
    {:ok, cache} = Todo.Cache.start()
    # create a User
    Todo.Cache.add_elem("alice")
    # get the User
    alice = Todo.Cache.query_elem("alice")
    # Add an entry of the User
    Todo.Server.add_entry(alice, %{date: ~D[2021-07-02], title: "Dentist"})
    # query the entry of the User , query result is a list of maps
    query_entry = Todo.Server.entries(alice, ~D[2021-07-02])
    # assert the data
    assert [%{date: ~D[2021-07-02], id: 1, title: "Dentist"}] == query_entry
  end
end
