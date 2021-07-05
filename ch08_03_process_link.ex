# spawn(fn ->
#   spawn(fn ->
#     IO.puts("process 2 started")
#     Process.sleep(2000)
#     IO.puts("process 2 ended")
#   end)
#   IO.puts("process 1 running..")
#   raise("something wrong in process 1")
# end)

# if 2 processes are linked and one of them terminates then the other process receives an exit signal
# an exit signal contains the pid of the crashed process and the exit reason
# if exit reason is other than :normal then the linked process is also taken down
# spawn_link : spawns a process and links it to the process from where the function has been invoked

spawn(fn ->
  spawn_link(fn ->
    IO.puts("process 2 started")
    Process.sleep(2000)
    IO.puts("process 2 ended")
  end)
  IO.puts("process 1 running..")
  raise("something wrong in process 1")
end)
