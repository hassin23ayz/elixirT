defmodule Todo.Server do
  use GenServer

  def start() do
    GenServer.start(__MODULE__, nil) # 3rd arg name: __MODULE__ imposes Singleton
                                     # here it is empty so that multiple instances of this
                                     # GenServer type module can be created
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

  def add_entry(pid, new_entry) do
    GenServer.cast(pid , {:add_entry, new_entry}) # 1st arg is not __MODULE__ ,
                                                  # letting multiple instances to be used
  end

  def entries(pid, date) do
    GenServer.call(pid, {:entries, date})         # 1st arg is not __MODULE__ ,
                                                  # letting multiple instances to be used
  end
end
