# tuple
IO.puts("-----1-----")
person = {"john", 25}
{name, age} = person
IO.inspect({name, age})

# Time
IO.puts("-----2-----")
tup_TS = {date, time} = :calendar.local_time()
IO.inspect(tup_TS)
{_date, time} = :calendar.local_time()
IO.inspect(_date)
IO.inspect(time)
date_time = {_, {hour,_,_}} = :calendar.local_time()
IO.inspect(date_time)
IO.inspect(hour)

# wrong file read
IO.puts("-----3-----")
#{:ok, contents} = File.read("example.txt")
{:error, reason} = File.read("example.txt")
IO.inspect(reason)

# Pinned var
IO.puts("-----4-----")
x = 10
{^x, _} = {10, "hello"}
#{^x, _} = {12, "hello"} #fails

# List
IO.puts("-----5-----")
[f,s,t] = [1,2,3]
IO.inspect([f,s,t])

# List head tail
IO.puts("-----6-----")
[min | leftover] = Enum.sort([3,5,2,1])
[min | leftover] = Enum.sort(leftover)
[min | _] = Enum.sort(leftover)
IO.inspect(min)

# Map
IO.puts("-----7-----")
%{age: age} = %{name: "john", age: 24}
IO.inspect(age)
