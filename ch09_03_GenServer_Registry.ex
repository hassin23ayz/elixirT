defmodule KeyValueStore do
  use GenServer
  def start_link(pid_key) do
    GenServer.start_link(__MODULE__, nil, name: get_registry_type_tuple(pid_key))
  end

  # 2 kinds of registration at Registry
  # type 1 [calling function of Registry]
  # Registry.register(:name_of_the_registry_created_before, {:process_name, process_Key}, arbtry_value)
  # type 2 [passing a tuple as the 3rd arg to GenServer.start_link() function]
  # tuple shape is {:via, Registry, {registry_name, process_key}}
  #                {:via, Registry, {registry_name, registered_key}}
  #                {:via, Registry, {registry_name, {__MODULE__, id}}}
  # in type 2 registration The GenServer will invoke a well defined Function of Registry Module to register the process
  defp get_registry_type_tuple(pid_key) do
    {:via, Registry, {:my_registry, {__MODULE__, pid_key}}}
  end

  @impl GenServer
  def init(_) do
    {:ok, %{}}                                  # return format {:ok, initial state}
  end

  @impl GenServer
  def handle_cast({:put, key, value}, state) do # client code write handler
    {:noreply, Map.put(state, key, value)}      # return format {:noreply, new state}.
  end

  @impl GenServer                               # client code read handler
  def handle_call({:get, key}, _, state) do     # handle_call/3 takes the request, the caller information {request_id, pid}, and the state.
    {:reply, Map.get(state, key), state}        # return format {:reply, response, new_state}.
  end

  def put(pid_key, key, value) do
    GenServer.cast(get_registry_type_tuple(pid_key), {:put, key, value})
  end

  def get(pid_key, key) do
    GenServer.call(get_registry_type_tuple(pid_key), {:get, key})
  end

  @impl GenServer
  def handle_info(:cleanup, state) do
    IO.puts "performing cleanup..."
    {:noreply, state}
  end
end

# usage
Registry.start_link(name: :my_registry, keys: :unique)
KeyValueStore.start_link(1) # 1 is the key of the process registered at Registry
KeyValueStore.put(1, :a, 1)
KeyValueStore.put(1, :b, 2)
IO.inspect(KeyValueStore.get(1, :a))
IO.inspect(KeyValueStore.get(1, :b))
IO.inspect(Registry.lookup(:my_registry, {KeyValueStore, 1}))
