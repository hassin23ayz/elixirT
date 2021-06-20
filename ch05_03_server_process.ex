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

# # usage 1
# pid = DatabaseServer.start()
# DatabaseServer.run_async(pid, "foo")
# DatabaseServer.run_async(pid, "bar")
# IO.inspect(DatabaseServer.get_result())
# # you can do whatever you want in the client (iex) process
# Enum.each(1..10, fn x -> IO.write("#{x} ") end)
# # and collect the result when you need it
# IO.inspect(DatabaseServer.get_result())
# IO.inspect(DatabaseServer.get_result())

# usage 2
pid = DatabaseServer.start()
Enum.map(1..10, fn x -> DatabaseServer.run_async(pid, "#{x}") end)
# collect a portion of the result
Enum.map(1..5, fn _  -> IO.inspect(DatabaseServer.get_result()) end)
# you can do whatever you want in the client (iex) process
Enum.each(1..10, fn _ -> IO.write(". ") end)
# and collect the result when you need it
Enum.map(1..4, fn _  -> IO.inspect(DatabaseServer.get_result()) end)
IO.inspect(DatabaseServer.get_result())
IO.inspect(DatabaseServer.get_result())
