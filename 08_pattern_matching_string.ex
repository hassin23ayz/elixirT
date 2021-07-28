# data structure apart example using string based key map
# this pattern is used in Phx controller action

home = %{"city"=> "Dhaka", "area"=> "Mirpur-14"}

defmodule Place do
  def get_city(%{"city"=> m_city}),              do: m_city
  def get_area(%{"area"=> m_area}),              do: m_area
end

IO.inspect(Place.get_city(home))
IO.inspect(Place.get_area(home))
