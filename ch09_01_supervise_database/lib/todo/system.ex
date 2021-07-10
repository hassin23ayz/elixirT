defmodule Todo.System do
  def start_link do
    Supervisor.start_link(
      [
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
# cache_db = Process.whereis(Todo.Database)
# Process.exit(cache_db, :kill)
# Process.whereis(Todo.Database)
