long_job =
fn ->
  Process.sleep(2000)
  :some_result
end

IO.puts("main process")
# The function Task.async/1 takes a zero-arity lambda
# spawns a separate process, and invokes the lambda in the spawned process.
# Task.async/1 returns immediately even if the lambda itself takes a long time to finish
task = Task.async(long_job)
# The starter process is not blocked and can perform some additional work
IO.puts("main process is unblocked")
# The return value of Task.async/1 is a struct that describes the running tasks. This
# struct can be passed to Task.await/1 to await the result of the task:
IO.inspect(Task.await(task))
