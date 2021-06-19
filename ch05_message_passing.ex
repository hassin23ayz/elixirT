# The content of the message is an Elixir term — anything you can store in a variable.
# Take the first message from the mailbox (FIFO queue)
# Try to match it against any of the provided patterns, going from top to bottom.
# If a pattern matches the message, run the corresponding code.
# If no pattern matches, put the message back into the mailbox at the same position it originally occupied.
# Then try the next message.
# If there are no more messages in the queue, wait for a new one to arrive.
# If the after clause is specified and no message is matched in the given amount of
# time, run the code from the after block.

get_result = fn ->
  receive do
    {:query, q_msg} ->
      "[#{q_msg}] recevd"
  after
    15000 -> IO.puts("message not received")
  end
end

fn_run_query = fn q_arg ->
  Process.sleep(2000)
  "#{q_arg} with 2 sec delay"
end

fn_async_query = fn arg ->
  caller = self()
  spawn(fn ->send(caller, {:query, fn_run_query.(arg)}) end)
end

# message passing demo
1..5
|> Enum.map(&fn_async_query.("query #{&1}"))
|> Enum.map(fn _ -> IO.inspect(get_result.()) end)
