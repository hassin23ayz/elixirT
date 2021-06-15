defmodule MultiDict do
  def new(), do: %{}

  def add(dict, key, value) do
    Map.update(dict, key, [value], fn values -> [value | values] end)
  end

  def get(dict, key) do
    Map.get(dict, key, [])
  end
end

defmodule TodoList do
  def new(), do: MultiDict.new()

  def add_entry(todo_list, entry) do
    MultiDict.add(todo_list, entry.date, entry)
  end

  def entries(todo_list, date) do
    MultiDict.get(todo_list, date)
  end
end

list =
  TodoList.new()
  |> TodoList.add_entry(%{date: ~D[2018-01-01], title: "Dinner"})
  |> TodoList.add_entry(%{date: ~D[2018-01-02], title: "Dentist"})
  |> TodoList.add_entry(%{date: ~D[2018-01-02], title: "Meeting"})

  IO.inspect(TodoList.entries(list, ~D[2018-01-02]))
  IO.inspect(TodoList.entries(list, ~D[2018-01-03]))
