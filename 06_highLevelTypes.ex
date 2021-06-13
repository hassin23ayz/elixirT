# keyword Lists
#> it is special case of lists = each element is a two element tuple
#> first  element = :AnAtom
#> second element = any type
weekdays = [{:sunday, 1},{:monday, 2}, {:tuesday, 3}, {:wednesday, 4}, {:thursday, 5}]
weekend  = [friday: 6, saturday: 7]

IO.puts(Keyword.get(weekdays, :tuesday))
IO.puts(weekend[:friday])

# mapset
#> a store of unique values where the value can be of any type
#> a mapset instance is also a map
days = MapSet.new([:sunday, :tuesday, :wednesday])
Enum.each(days, &IO.puts/1)
IO.puts("-------------------")

#> let's put a unique value
days = MapSet.put(days, :friday)
Enum.each(days, &IO.puts/1)
IO.puts("-------------------")

#> let's put a same value
days = MapSet.put(days, :sunday)
Enum.each(days, &IO.puts/1)
IO.puts("-------------------")

# IO List : incrementally building output that will be forwarded to an I/O device like network / file
# you can combine characater lists / binary strings into a deeply nested list
# IO list is useful at incrementally building a stream of bytes
# IO list[O(1)] is better than List[O(n)]
iolist = [[['H', 'e'], "llo,"], " worl", "d!"]
IO.puts(iolist)
