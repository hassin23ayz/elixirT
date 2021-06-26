defmodule Todo.Server do
  use GenServer

  def start do
    GenServer.start(Todo.Server, nil, name: __MODULE__)
  end

  def init(_) do
    {:ok, Todo.List.new()}
  end

  def handle_cast({:add_entry, new_entry}, state) do
    {:noreply, Todo.List.add_entry(state, new_entry)}
  end

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
