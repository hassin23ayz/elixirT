defmodule TodoList do
  def new(), do: %{}

  def add_entry(todo_list, date, title) do
    Map.update(todo_list, date, [title], fn titles -> [title | titles] end)
  end

  def entries(todo_list, date) do
    Map.get(todo_list, date, [])
  end
end

list =
  TodoList.new()
  |> TodoList.add_entry(~D[2018-01-01], "Dinner")
  |> TodoList.add_entry(~D[2018-01-02], "Dentist")

IO.inspect(TodoList.entries(list, ~D[2018-01-01]))
IO.inspect(TodoList.entries(list, ~D[2018-01-03]))
