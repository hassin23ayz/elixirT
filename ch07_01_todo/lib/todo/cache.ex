# each user will have its own todo.list
# the todo.list will be under a todo.server (GenServer type)
# each todo.server will be under a list which is this module
# the cache module is also run as a GenServer
defmodule Todo.Cache do
  use GenServer

  def start do
    GenServer.start(__MODULE__, nil, name: __MODULE__) # name: __MODULE__ imposes Singleton
  end

  # creates an empty map
  # map will hold server PID and name
  @impl GenServer
  def init(_) do
    {:ok, %{}}
  end

  @impl GenServer
  def handle_cast({:add_elem, name}, state) do
    {:ok, new_server} = Todo.Server.start()
    {:noreply, Map.put(state, name, new_server)}
  end

  def add_elem(name) do           # usage example : $iex> Todo.Cache.add_elem("user1")
    GenServer.cast(__MODULE__, {:add_elem, name}) # 1st arg: __MODULE__ imposes Singleton
  end

  def query_elem(name) do
    GenServer.call(__MODULE__, {:get_elem, name}) # 1st arg: __MODULE__ imposes Singleton
  end

  @impl GenServer
  def handle_call({:get_elem, name}, _ , state) do
    {:reply, Map.get(state, name), state}
  end

end


# usage
# Todo.Cache.start()
# Enum.each(1..100, fn index -> Todo.Cache.add_elem("user #{index}") end)
# Todo.Cache.query_elem("user 99")
# Todo.Cache.query_elem("user 1")
