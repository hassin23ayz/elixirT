defmodule Todo.Cache do
  use GenServer

  def start do
    GenServer.start(__MODULE__, nil, name: __MODULE__)
  end

  @impl GenServer
  def init(_) do
    Todo.Database.start()
    {:ok, %{}}
  end

  @impl GenServer
  def handle_cast({:add_elem, name}, state) do
    {:ok, new_server} = Todo.Server.start(name)
    {:noreply, Map.put(state, name, new_server)}
  end

  def add_elem(name) do
    GenServer.cast(__MODULE__, {:add_elem, name})
  end

  def query_elem(name) do
    GenServer.call(__MODULE__, {:get_elem, name})
  end

  @impl GenServer
  def handle_call({:get_elem, name}, _ , state) do
    {:reply, Map.get(state, name), state}
  end

end


# usage
# {:ok, cache} = Todo.Cache.start()
# Todo.Cache.add_elem("alice")
# alice = Todo.Cache.query_elem("alice")
# Todo.Server.add_entry(alice, %{date: ~D[2021-07-02], title: "Dentist"})
# query_entry = Todo.Server.entries(alice, ~D[2021-07-02])

# CTRL+Z
# {:ok, cache} = Todo.Cache.start()
# Todo.Cache.add_elem("alice")
# alice = Todo.Cache.query_elem("alice")
# query_entry = Todo.Server.entries(alice, ~D[2021-07-02])
