# in our ch09_01 design the Database module contains 4 pids as it's state
# these pids are initialized when Database module starts processes of type DatabaseWorker
# the DatabaseWorker processes are linked back to the Database module
# So if any one of the DatabaseWorker process gets terminated then the database module will also die
# A good design requires supervisor to supervise these DatabaseWorker processes

# Now if the Supervisor at top hierarchy(System Module) wants to get hold of these DatabaseWorker pids
# it can't . The reason is these pids are stored in a map as a state of Database module .
# Registry Module of Elixir Standard library can help us in this regard
# In Registry Module processes can be stored as a key based lookup

# the process Registry itself is a process
# :name is the Registry Name
Registry.start_link(name: :my_registry, keys: :unique)

# now Let's Register a Process
spawn(fn ->
  Registry.register(:my_registry, {:recv_process, 1}, nil) # 1st arg : name of the registry
                                                           # 2nd arg : name of the spawned process
                                                           # consisting of process name and a key
                                                           # 3rd arg : arbritary value
  receive do
    msg ->
      IO.inspect(msg)
  end
end)

# discovering the process
# [{recv_process_pid, value}] = Registry.lookup(:my_registry, {:recv_process, 1})

# IO.inspect(recv_process_pid)
# IO.inspect(value)
IO.inspect(Registry.lookup(:my_registry, {:recv_process, 1}))
