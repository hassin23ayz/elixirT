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
        Todo.ProcessRegistry,
        Todo.Database,
        Todo.Cache
      ],
      strategy: :one_for_one
    )
  end
end

# usage
# <<persistence test>>
# Todo.System.start_link()
# bobs_list = Todo.Cache.server_process("bobss list")
# Todo.Server.add_entry(bobs_list, %{date: ~D[2021-07-02], title: "Dentist"})
# query_entry = Todo.Server.entries(bobs_list, ~D[2021-07-02])

# CTRL+Z
# Todo.System.start_link()
# bobs_list = Todo.Cache.server_process("bobss list")
# query_entry = Todo.Server.entries(bobs_list, ~D[2021-07-02])

# <<process restart test>>
# cache_pid = Process.whereis(Todo.Cache)
# Process.exit(cache_pid, :kill)
# Process.whereis(Todo.Cache)

# << kill>restart of one Todo.Server process does not impact other >>
# bobs_list = Todo.Cache.server_process("Bob's list")
# alices_list = Todo.Cache.server_process("Alice's list")
# Process.exit(bobs_list, :kill)
# Todo.Cache.server_process("Bob's list")
# Todo.Cache.server_process("Alice's list")
