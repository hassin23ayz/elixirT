defmodule Todo.System do
  def start_link do
    Supervisor.start_link(    # starts a supervisor process
      [Todo.Cache],           # List of child specifications , here it is a module name
                              # when supervisor process starts it invokes Todo.Cache.start_link()
                              # there a process gets started and is linked back to this supervisor process
      strategy: :one_for_one  # restart strategy

                              # the Supervisor process created here gets linked back to the caller
    )
  end
end

# the cache process is started as the child of the supervisor process
# so we say that it is supervised
# if the Cache process crashes its supervisor will restart it

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

# <<Supervisor Limit test>>
# Todo.System.start_link()
# for _ <- 1..4 do
#   Process.exit(Process.whereis(Todo.Cache), :kill)
#   Process.sleep(200)
# end
