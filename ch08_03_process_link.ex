# ----------------------------[no link]-----------------------
# 2 processes can run in parallel .
# fault in one process does not affect the other

# spawn(fn ->
#   spawn(fn ->
#     IO.puts("process 2 started")
#     Process.sleep(2000)
#     IO.puts("process 2 ended")
#   end)
#   IO.puts("process 1 running..")
#   raise("something wrong in process 1")
# end)

# ----------------------------[linked , exit]--------------------------------
# if 2 processes are linked and one of them terminates then the other process receives an exit signal
# an exit signal contains the pid of the crashed process and the exit reason
# if exit reason is other than :normal then the linked process is also taken down
# spawn_link : spawns a process and links it to the process from where the function has been invoked

# spawn(fn ->
#   spawn_link(fn ->
#     IO.puts("process 2 started")
#     Process.sleep(2000)
#     IO.puts("process 2 ended (never gets printed)")
#   end)
#   IO.puts("process 1 running..")
#   raise("something wrong in process 1")
# end)

# ----------------------------[linked , trap exit]-----------------------
# usually you don't want a linked process to crash
# Actually the linked process should trap the exit

# spawn(fn ->                           # process 1
#      Process.flag(:trap_exit, true)   # process 1 configures itself to trap exit signal given by other linked process

#      spawn_link(fn ->                 # process 1 creates another process 2 . the processes are linked
#         IO.puts("process 2 running..")
#         Process.sleep(2000)
#         raise("something wrong in process 2") # process 2 raises an error
#      end)

# receive do
#   msg ->
#     IO.inspect(msg)
# end

# end)

# ----------------------------[monitor]-----------------------
spawn(fn ->
  IO.puts("process 1 running..")
  ref_p2 = spawn_link(fn ->
    IO.puts("process 2 running..")
  end)

  Process.monitor(ref_p2) #process 1 monitors process 2

  receive do
    msg ->
      IO.inspect(msg)
  end

end)
