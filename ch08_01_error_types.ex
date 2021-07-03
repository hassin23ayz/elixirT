# -the aim of fault tolerance is to acknowledge the existence of failures
# -the entire system should not shutdown, you should be able to provide some service
# -for example if the database server becomes unreachable , you can still serve the data from the cache
# -in beam world 2 concurrent process are completely separated, they share no memory
# -and a crash in one process cannot by default compromise the execution flow of another
# -BEAM distinguishes 3 types of runtime errors :
# -error_type contain an atom = [:error, :exit, :throw]

# ----------------------------- :error -----------------------------------------------

# ----(1)-----> arithmetic :error
# 1/0

# ----(2)-----> undefined function :error
# defmodule Module do
# end
# Module.nonexistent_function()

# ----(3)-----> FunctionClause :error / pattern matching error
# List.first({1,2,3})

# ----(4)-----> a synchronous GenServer call if the response msg does not arrive in a given time interval a runtime error happens

# ----(5)-----> raise
# raise("something is wrong")

# ----(6)-----> ! sign importance = if your function explicitly raises an error , you should append the ! character to its name
# File.open!("non-existent-file") # raises an error if a file cannot be opened
# File.open("non-existent-file")  # just returns the information that the file cannot be opened
# ------------------------------------------------------------------------------------

# ----------------------------- :exit -----------------------------------------------
# -deliberately terminating a process
spawn(fn ->
  exit("i am done")
  IO.puts("never executes")
end)
# ------------------------------------------------------------------------------------

# ----------------------------- :throw -----------------------------------------------
# -it's usage should be avoided
throw(:thrown_value)
# ------------------------------------------------------------------------------------
