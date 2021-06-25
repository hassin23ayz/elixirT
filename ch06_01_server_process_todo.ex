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

# a generic server process .
# :call is for synchronous handling
# :cast is for asynchronous handling
# uses a concept called callback module
defmodule ServerProcess do
  def start(callback_module) do
    spawn(fn ->
      initial_state = callback_module.init
      loop(callback_module, initial_state)
    end)
  end

  defp loop(callback_module, current_state) do
    receive do
      {:call, request, caller} ->
        {response, new_state} =
          callback_module.handle_call(
            request,
            current_state
          )

        send(caller, {:response, response})
        loop(callback_module, new_state)

      {:cast, request} ->
        new_state =
          callback_module.handle_cast(
            request,
            current_state
          )

        loop(callback_module, new_state)
    end
  end

  def call(server_pid, request) do
    send(server_pid, {:call, request, self()})

    receive do
      {:response, response} ->
        response
    end
  end

  def cast(server_pid, request) do
    send(server_pid, {:cast, request})
  end
end

# A server on top of generic server
defmodule TodoServer do
  def start do
    ServerProcess.start(TodoServer)
  end

  def init do
    TodoList.new()
  end

  def add_entry(pid, new_entry) do
    ServerProcess.cast(pid, {:add_entry, new_entry})
  end

  def handle_cast({:add_entry, new_entry}, state) do
    TodoList.add_entry(state, new_entry)
  end

  def entries(pid, date) do
    ServerProcess.call(pid, {:entries, date})
  end

  def handle_call({:entries, date}, todo_list) do
    {TodoList.entries(todo_list, date), todo_list}
  end
end

# usage
pid = TodoServer.start()
TodoServer.add_entry(pid, %{date: ~D[2018-01-01], title: "Dinner"})
TodoServer.add_entry(pid, %{date: ~D[2018-01-02], title: "Dentist"})
TodoServer.add_entry(pid, %{date: ~D[2018-01-02], title: "Meeting"})

IO.inspect(TodoServer.entries(pid, ~D[2018-01-02]))
