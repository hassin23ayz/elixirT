# Recursion

defmodule PlayGround do
  def print(0), do: :ok

  def print(n) do
    if n < 0 do
      IO.puts("invalid input")
      print(0)
    else
      print(n-1)
      IO.puts(n)
    end
  end
end

PlayGround.print(-1)
PlayGround.print(10)
