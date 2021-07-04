# in elixir try catch error handling is just like any other language
# if a runtime error is not handled , the corresponding process will terminate

try do
  1/0
catch type, value ->
  IO.puts("Error\n #{inspect(type)}\n #{inspect(value)}")
after
  IO.puts("always executes")
end

# a function which receives another function and executes it by a try catch block
try_helper = fn fun2exe ->
  try do
    fun2exe.()
    IO.puts("No error")
  catch type, value ->
    IO.puts("Error\n #{inspect(type)}\n #{inspect(value)}")
  end
end

fun2exe = fn ->
  raise("intentional raise of error")
end

# calling our function via the try_helper
try_helper.(fun2exe)

# the idea is to let the process crash and restart with a new state
# Most unpredictable, hard to reproduce bugs occurs due to the corruptness of the state (Heisenbug category)
