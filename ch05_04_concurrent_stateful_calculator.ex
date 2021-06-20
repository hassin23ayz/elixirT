defmodule Calculator do
  def start do
    spawn(fn ->
      initial_value = 0
      loop(initial_value)
    end)
  end

  def get_result(pid) do
    send(pid, {:result_req, self()})

    receive do
      {:result_resp, value} ->
        value
    end
  end

  def add(pid, value), do: send(pid, {:add, value})
  def sub(pid, value), do: send(pid, {:sub, value})
  def mul(pid, value), do: send(pid, {:mul, value})
  def div(pid, value), do: send(pid, {:div, value})

  defp loop(current_value) do
    new_value =
      receive do
        {:result_req, caller} ->
          send(caller, {:result_resp, current_value})
          current_value

        {:add, value} ->
          current_value + value

        {:sub, value} ->
          current_value - value

        {:mul, value} ->
          current_value * value

        {:div, value} ->
          current_value / value

        invalid_request ->
          IO.puts("invalid request #{inspect(invalid_request)}")
      end

    loop(new_value)
  end
end


pid = Calculator.start()
Calculator.add(pid, 4)
Calculator.sub(pid, 2)
IO.inspect(Calculator.get_result(pid))
IO.inspect(Calculator.get_result(pid))
