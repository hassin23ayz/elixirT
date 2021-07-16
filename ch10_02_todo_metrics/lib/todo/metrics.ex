defmodule Todo.Metrics do
  use Task

  def start_link(_arg) do
    Task.start_link(&loop/0)   # start_link/1 starts a seprate process and links the process to the caller
                               # the started process calls the zero arity lambda
                               # when the lambda finishes it returns with :normal
                               # unlike Task.async/1 ; Task.start_link/1 wont send any message to the caller
  end

  defp loop() do
    Process.sleep(:timer.seconds(10))
    IO.inspect(collect_metrics())
    loop()
  end

  defp collect_metrics() do
    [
    memory_usage: :erlang.memory(:total),
    process_count: :erlang.system_info(:process_count)
    ]
  end
end
