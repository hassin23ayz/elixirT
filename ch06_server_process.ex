# A server process is an informal name for a process that runs for a long time (or forever)
# and can handle various requests (messages).

# Notice that functions in this module run in different processes. The function
# start/0 is called by clients and runs in a client process. The private function loop/0
# runs in the server process. It’s perfectly normal to have different functions from the
# same module running in different processes

defmodule DatabaseServer do
  def start do
    spawn(&loop/0)
  end

  def run_async(server_pid, query_def) do
    send(server_pid, {:run_query, self(), query_def})
  end

  def get_result do
    receive do
      {:query_result, result} -> result
    after
      5000 -> {:error, :timeout}
    end
  end

  defp loop do
    receive do
      {:run_query, caller, query_def} ->
        send(caller, {:query_result, run_query(query_def)})
    end

    loop()
  end

  defp run_query(query_def) do
    Process.sleep(2000)
    "#{query_def} result"
  end
end

# usage
pid = DatabaseServer.start()
DatabaseServer.run_async(pid, "foo")
IO.inspect(DatabaseServer.get_result())
