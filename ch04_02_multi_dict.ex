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

  def add_entry(todo_list, date, title) do
    MultiDict.add(todo_list, date, title)
  end

  def entries(todo_list, date) do
    MultiDict.get(todo_list, date)
  end

  def today_entry(todo_list) do
    {:ok, today} = DateTime.now("Etc/UTC")
    MultiDict.get(todo_list, DateTime.to_date(today))
  end
end

list =
  TodoList.new()
  |> TodoList.add_entry(~D[2018-01-01], "Dinner")
  |> TodoList.add_entry(~D[2018-01-02], "Dentist")
  |> TodoList.add_entry(~D[2018-01-02], "Meeting")

IO.inspect(TodoList.entries(list, ~D[2018-01-02]))
IO.inspect(TodoList.entries(list, ~D[2018-01-03]))

IO.inspect(TodoList.today_entry(list))
