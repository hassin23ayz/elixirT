defmodule Todo.ProcessRegistry do             # this module helps us to use the Registry module
  def start_link do                           # Registry is itself a process , this function starts it
    Registry.start_link(name: __MODULE__, keys: :unique )
  end

  def via_tuple(key) do                       # replies a Tuple , later used by GenServer Based processes to register with this Registry
    {:via, Registry, {__MODULE__, key}}
  end

  def child_spec(_) do                        # this module is not of GenServer or SuperVisor type so it needs explicit chile_spec definition (Registry child_spec has been used)
    Supervisor.child_spec(
      Registry,
      id: __MODULE__,
      start: {__MODULE__,:start_link, []}
    )
  end
end
