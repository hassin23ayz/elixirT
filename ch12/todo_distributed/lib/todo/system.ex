# The supervisor starts a child, waits for it to finish,
# and then moves on to start the next child.
# When the worker is a GenServer, the next child is started
# only after the init/1 callback function
# for the current child is finished
# Always make sure your init/1 functions run quickly

defmodule Todo.System do
  def start_link do
    Supervisor.start_link(
      [                          # order of the child specifications matter
        #Todo.ProcessRegistry,
        Todo.Database,
        Todo.Cache,
        Todo.Web,
        #Todo.Metrics
      ],
      strategy: :one_for_one
    )
  end
end
