# support for managing many todo list instances is being developed
# the end goal is to use this infrastructure in an HTTP server
# in elixir/erlang HTTP server typically use a separate process for each request

# if your server process takes one micro second then
# to-do cache could handle a load upto 1,000,000 requests per second

# A process is good enough if its request handling rate is at least equal to the incoming rate
# Because a process runs only one request at a time, it's internal state is consistent. there can't be multiple
# simulateneous updates of the process state, which makes race conditions in a single process impossible

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
