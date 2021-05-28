# function needs to be inside a Module in elixir
# module is a collection of functions
# defmodule naming convention: CamelCase
# module is somewhat like a namespace

defmodule PlayGround do
  # function must always be part of a module
  # function follows same naming onvention as variables
  def area(a, b) do
    # the last line of the function is the function's return value
    a * b
  end

  # nested module
  defmodule Circle do
    def area(r) do
      3.14159 * r * r
    end
  end

  # single line function
  def volume(x,y,z), do: x * y * z
end
