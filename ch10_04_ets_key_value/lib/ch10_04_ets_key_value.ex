defmodule EtsKeyValue do
  use GenServer
                          # an ETS table is released from memory when the owner process terminates.
                          # Therefore, you need to have a distinct, long-running process that creates
                          # and owns the table.

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl GenServer
  def init(_) do
    :ets.new(
      __MODULE__,                                       # name of the ETS table
      [:named_table, :public, write_concurrency: true]  # table options
    )
    {:ok, nil}
  end

  def put(key, value) do
    :ets.insert(__MODULE__, {key, value})
  end

  def get(key) do
    case :ets.lookup(__MODULE__, key) do                # performs ETS lookup
      [{^key, value}] -> value                            # something found
      [] -> nil                                           # nothing found
    end
  end

end

# usage
# EtsKeyValue.start_link()
# EtsKeyValue.put(:first_entry, 230)
# IO.inspect(EtsKeyValue.get(:first_entry))

# benchmark usage
# mix run -e "Bench.run(EtsKeyValue)"
# mix run -e "Bench.run(EtsKeyValue, concurrency: 1000, num_updates: 100)"

self()
