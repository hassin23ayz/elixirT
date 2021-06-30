# the core module that holds the data
# [uses structure, Enum]
defmodule TodoList do
  defstruct auto_id: 1, entries: %{}

  def new(entries \\ []) do
    Enum.reduce(
      entries,
      %TodoList{},
      &add_entry(&2, &1)        # reverse order &add_entry(%TodoList{}, entries)
    )
  end

  def add_entry(todo_list, entry) do
    entry = Map.put(entry, :id, todo_list.auto_id)
    new_entries = Map.put(todo_list.entries, todo_list.auto_id, entry)

    %TodoList{todo_list | entries: new_entries, auto_id: todo_list.auto_id + 1}
  end

  def entries(todo_list, date) do
    todo_list.entries
    |> Stream.filter(fn {_, entry} -> entry.date == date end)
    |> Enum.map(fn {_, entry} -> entry end)
  end

  def update_entry(todo_list, %{} = new_entry) do
    update_entry(todo_list, new_entry.id, fn _ -> new_entry end)
  end

  def update_entry(todo_list, entry_id, updater_fun) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error ->
        todo_list

      {:ok, old_entry} ->
        new_entry = updater_fun.(old_entry)
        new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
        %TodoList{todo_list | entries: new_entries}
    end
  end

  def delete_entry(todo_list, entry_id) do
    %TodoList{todo_list | entries: Map.delete(todo_list.entries, entry_id)}
  end
end

# A server on top of generic server
defmodule TodoServer do
  use GenServer

  def start do
    GenServer.start(TodoServer, nil, name: __MODULE__)
  end

  def init(_) do
    {:ok, TodoList.new()} #TodoServer data type is TodoList
  end

  def handle_cast({:add_entry, new_entry}, state) do
    {:noreply, TodoList.add_entry(state, new_entry)}
  end

  def handle_call({:entries, date}, _ , state) do
    {:reply, TodoList.entries(state, date), state}
  end

  def add_entry(new_entry) do
    GenServer.cast(__MODULE__ , {:add_entry, new_entry})
  end

  def entries(date) do
    GenServer.call(__MODULE__, {:entries, date})
  end
end

# usage
IO.inspect(TodoServer.start())
TodoServer.add_entry(%{date: ~D[2018-01-01], title: "Dinner"})
TodoServer.add_entry(%{date: ~D[2018-01-02], title: "Dentist"})
TodoServer.add_entry(%{date: ~D[2018-01-02], title: "Meeting"})

IO.inspect(TodoServer.entries(~D[2018-01-02]))

IO.inspect(TodoServer.start()) # will return error
