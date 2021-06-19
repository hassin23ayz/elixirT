# a lambda function with arg
fn_run_query = fn arg_of_fn->
  Process.sleep(2000)
  IO.puts("#{arg_of_fn} passed as arg")
end

# shell is blocked until lamda is done (2 second)
# fn_run_query.(20)

# # if you run 5 queries it will take 10 seconds to get all the results
# Enum.map(1..5, &fn_run_query.(&1))

# spawn/1 takes a zero arity lambda
# fn_zero_arity = fn ->
#   fn_run_query.(20)
# end
# pid1 = spawn(fn_zero_arity)
# IO.inspect(pid1)

# process is a concurrent thread of execution
# The function spawn/1 takes a zero-arity lambda that will run in the new process. After the
# process is created, spawn immediately returns, and the caller process’s execution continues.
# The provided lambda is executed in the new process and therefore runs concurrently.
# After the lambda is done, the spawned process exits, and its memory is released.
fn_async_query = fn arg ->
  pid = spawn(fn -> fn_run_query.(arg) end)
  IO.inspect(pid)
end
# fn_async_query.(33)
Enum.map(6..12, &fn_async_query.(&1))

git config --global user.email "you@example.com"
git config --global user.name "Your Name"
