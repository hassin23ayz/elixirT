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
    GenServer.start(                     # starts the process
      KeyValueStore,                     # the GenServer behavioUr takes KeyValueStore as the callback module
      nil,                               # additional value can be passed
      name: __MODULE__                   # Registers the process under a macro name
      )
  end

  def init(_) do                         # takes 2nd argument of GenServer.start/2
    :timer.send_interval(5000, :cleanup) # sets up periodic message sending
    {:ok, %{}}                           # return format must be {:ok, initial_state}
                                         # returns an empty map
  end

  def handle_cast({:put, key, value}, state) do # handle_cast/2 accepts the request and the state
    {:noreply, Map.put(state, key, value)}      # return format must be {:noreply, new_state}.
  end
                                                # GenServer.call/2 doesn’t wait indefinitely for a response.
                                                # By default, if the response message doesn’t arrive in five seconds,
                                                # an error is raised in the client process.
  @impl GenServer                               # tells the compiler that the function about to be defined is a callback function for the GenServer behaviour.
  def handle_call({:get, key}, _, state) do     # handle_call/3 takes the request, the caller information {request_id, pid}, and the state.
    {:reply, Map.get(state, key), state}        # return format must be {:reply, response, new_state}.
  end

  def put(key, value) do
    GenServer.cast(__MODULE__, {:put, key, value})     # msg sent to server process is more than request payload
                                                           # there is additional data such as the request type
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def handle_info(:cleanup, state) do
    IO.puts "performing cleanup..."
    {:noreply, state}
  end

  def end_the_process do
    GenServer.stop(__MODULE__, :normal)
  end
end

# usage
{:ok, pid} = KeyValueStore.start()
KeyValueStore.put(:a, 1)
KeyValueStore.put(:b, 2)
IO.inspect(KeyValueStore.get(:a))
IO.inspect(KeyValueStore.get(:b))
IO.inspect(KeyValueStore.get(:c))

Process.sleep(20000)
KeyValueStore.end_the_process()
