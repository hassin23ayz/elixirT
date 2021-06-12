# pattern matching in function

defmodule Geometry do
  def area({:rectangle, a,b}) do
    a * b
  end

  def area({:square, a}) do
    a * a
  end

  def area({:circle, r}) do
    r * r * 3.14159
  end

  def area(_) do
    :error
  end
end

IO.inspect(Geometry.area({:circle, 2}))
IO.inspect(Geometry.area({:square, 3}))
IO.inspect(Geometry.area({:rectangle, 20, 30}))
IO.inspect(Geometry.area({:triangle, 2, 3, 5}))
