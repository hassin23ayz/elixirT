# each user will have its own todo.list
# the todo.list will be under a todo.server (GenServer type)
# each todo.server will be under a list which is this module
# the cache module is also run as a GenServer
defmodule Todo.Cache do
  use GenServer, Todo.Server

  def start do
    GenServer.start(Todo.Cache, nil, name: __MODULE__)
  end

  # creates an empty map
  def init(_) do
    {:ok, %{}}
  end

  def handle_cast({:add_elem, name}, state) do
    state = Map.put(state, name, Todo.Server.start())
    {:noreply, state}
  end

  def add_elem(name) do
    GenServer.cast(__MODULE__, {:add_elem, name})
  end

  def query_elem(name) do
    GenServer.call(__MODULE__, {:get_elem, name})
  end

  defp find_elem(items, name) do
    case Map.fetch(items, name) do
      :error ->
        IO.puts("no match, creating new ")
        add_elem(name)
      {:ok, elem_found} ->
        IO.puts("elem found")
        elem_found
    end
  end

  def handle_call({:get_elem, name}, _ , state) do
    {:reply, find_elem(state, name), state}
  end

  # this function will query a todo.server from it's state: it is a map
  # if the todo.server is not in the state then this function will create one and put it there

  # def server_process(cache_list, query_name) do
  #   GenServer.call(__MODULE__, {:entries, date})
  # end

  # def handle_call() do
  #   case Map.fetch(cache_list, query_name) do
  #     :error ->
  #       IO.puts("no match, creating new ")
  #       Map.put_new(cache_list, query_name, Todo.Server.start())
  #     {:ok, elem_found} ->
  #       IO.puts("elem found")
  #       elem_found
  #   end
  # end
end
