# a lambda function with arg
fn_run_query = fn arg_of_fn->
  Process.sleep(2000)
  IO.puts("#{arg_of_fn} passed as arg")
end

# shell is blocked until lamda is done (2 second)
fn_run_query.(20)

# if you run 5 queries it will take 10 seconds to get all the results
Enum.map(1..5, &fn_run_query.(&1))

# spawn/1 takes a zero arity lambda
fn_zero_arity = fn ->
  fn_run_query.(20)
end
pid1 = spawn(fn_zero_arity)
IO.inspect(pid1)

# all the above as an async query
fn_async_query = fn arg ->
  pid = spawn(fn -> fn_run_query.(arg) end)
  IO.inspect(pid)
end
fn_async_query.(33)
Enum.map(6..12, &fn_async_query.(&1))
