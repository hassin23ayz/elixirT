defmodule Todo.Server do
  use GenServer

  def start() do              # passed arg server_name must be of type :Atom
                              # for example $iex> Todo.Server.start(:hassin)
    GenServer.start(Todo.Server, nil)
  end

  @impl GenServer
  def init(_) do
    {:ok, Todo.List.new()}
  end

  @impl GenServer
  def handle_cast({:add_entry, new_entry}, state) do
    {:noreply, Todo.List.add_entry(state, new_entry)}
  end

  @impl GenServer
  def handle_call({:entries, date}, _ , state) do
    {:reply, Todo.List.entries(state, date), state}
  end

  def add_entry(new_entry) do
    GenServer.cast(__MODULE__ , {:add_entry, new_entry})
  end

  def entries(date) do
    GenServer.call(__MODULE__, {:entries, date})
  end
end
