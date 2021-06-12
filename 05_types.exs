# tuple : group a fixed number of elements together
person = {"Bob", 25}
IO.inspect(person)

# List (can hold any type of a numbers of data)
myLangs = [ "c", "c++", "python", "vhdl", "elixir"]
IO.puts(myLangs)

# Map starts with '%{'  ends with '}' the keys can be in any order
person = %{ name: "Bob", age: 45}
IO.puts(person[:name])

# List with Map
people = [
          %{ name: "Tom",    age: 8},
          %{ name: "Jerry",  age: 5},
          %{ name: "Dexter", age: 15}
        ]
IO.puts( Enum.at(people, 2)[:name] )

#range
a_range = Range.new(-1,1)
Enum.each(a_range, fn x-> IO.puts(x) end)

b_range = 1..33
Enum.each(b_range, fn x-> IO.puts(x) end)
