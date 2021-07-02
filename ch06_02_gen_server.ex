# <<GenServer>> handles various kinds of edge cases and is battle tested in production in complex concurrent systems
# GenServer is implemented in plain Erlang and Elixir included in the Erlang Standard Library

# <<OTP behavioUr>> behavioUr is a generic code that implements a common pattern

# Erlang standard library includes the following OTP behavioUrs
# > gen_event
# > application
# > gen_statem
# > GenServer
# > supervisor

defmodule KeyValueStore do
  use GenServer                          # the use macro injects a bunch of function in the calling module

  def start do
    GenServer.start(KeyValueStore, nil)  # starts the process, the GenServer behavioUr takes KeyValueStore as the callback module
                                         # the 2nd arg (nil) is passed to init()
                                         # returns {:ok, pid}
                                         # a 3rd argument can register the created process under a local name
                                         # time most frequent approach is to use the same name as the module name __MODULE__
                                         # GenServer.start(__MODULE__, nil, name: __MODULE__)
                                         # __MODULE__ imposes Singleton, leave it blank to allow creating multiple instances
  end

  def init(_) do                         # takes 2nd argument of GenServer.start/2
    :timer.send_interval(5000, :cleanup) # sets up periodic message sending
    {:ok, %{}}                           # return format must be {:ok, initial state} state is the data of this module
                                         # returns an empty map
  end

  def handle_cast({:put, key, value}, state) do # handle_cast/2 accepts the request and the state
    {:noreply, Map.put(state, key, value)}      # return format must be {:noreply, new state}.
  end

  @impl GenServer                               # tells the compiler that the function about to be defined is a callback function for the GenServer behaviour.
  def handle_call({:get, key}, _, state) do     # handle_call/3 takes the request, the caller information {request_id, pid}, and the state.
    {:reply, Map.get(state, key), state}        # return format must be {:reply, response, new_state}.
  end

  def put(pid, key, value) do
    GenServer.cast(pid, {:put, key, value})     # msg sent to server process is more than request payload
                                                # there is additional data such as the request type
                                                # __MODULE__ instead of pid , imposes Singleton
  end

  def get(pid, key) do
    GenServer.call(pid, {:get, key})            # GenServer.call/2 doesn’t wait indefinitely for a response.
                                                # By default, if the response message doesn’t arrive in five seconds,
                                                # an error is raised in the client process.
                                                # you can alter this by using GenServer.call(pid, request, timeout) //timeout is given in ms
                                                # __MODULE__ instead of pid , imposes Singleton
  end

  def handle_info(:cleanup, state) do
    IO.puts "performing cleanup..."
    {:noreply, state}
  end
end

# usage
{:ok, pid} = KeyValueStore.start()
KeyValueStore.put(pid, :a, 1)
KeyValueStore.put(pid, :b, 2)
IO.inspect(KeyValueStore.get(pid, :a))
IO.inspect(KeyValueStore.get(pid, :b))
IO.inspect(KeyValueStore.get(pid, :c))
