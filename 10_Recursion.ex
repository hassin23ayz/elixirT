# Recursion
# tail-call optimization : calling a function does not result in the usual stack push

defmodule NaturalNums do
  def print(0), do: :ok

  def print(n) do
    if n < 0 do
      IO.puts("invalid input")
      print(0)
    else
      print(n-1)                    # tail-call
      IO.puts(n)
    end
  end
end

NaturalNums.print(-1)
NaturalNums.print(10)
IO.puts("------------------------")

defmodule ListSum do
  def sum([]), do: 0
  def sum([head|tail]) do
    head + sum(tail)                # tail-call
  end
end

IO.inspect(ListSum.sum([1,2,3,4,5]))
