# each user will have its own todo.list
# the todo.list will be under a todo.server (GenServer type)
# each todo.server will be under a list which is this module
# the cache module is also run as a GenServer
defmodule Todo.Cache do
  use GenServer

  def start do
    GenServer.start(__MODULE__, nil, name: __MODULE__)
  end

  # creates an empty map
  # map will hold server PID and name
  @impl GenServer
  def init(_) do
    {:ok, %{}}
  end

  @impl GenServer
  def handle_cast({:add_elem, name}, state) do
    {:ok, new_server} = Todo.Server.start(name)
    {:noreply, Map.put(state, name, new_server)}
  end

  def add_elem(name) do           # usage example : $iex> Todo.Cache.add_elem(:user1)
    GenServer.cast(__MODULE__, {:add_elem, name})
  end

  # def query_elem(name) do
  #   GenServer.call(__MODULE__, {:get_elem, name})
  # end

  # defp find_elem(items, name) do
  #   case Map.fetch(items, name) do
  #     :error ->
  #       IO.puts("no match, creating new ")
  #       add_elem(name)
  #     {:ok, elem_found} ->
  #       IO.puts("elem found")
  #       elem_found
  #   end
  # end

  # def handle_call({:get_elem, name}, _ , state) do
  #   {:reply, find_elem(state, name), state}
  # end

end
