# lamda function : a function definition assigned to a variable
s = fn x -> x*x end
s.(2)

# lamda function : another module function can be assigned to a variable using & operator
x = &IO.puts/1
x.("hello")

# lamda function invocation with iterable
Enum.each(1..10, x)

# lamda function with arguments passing using capture operator
# the first & op say capture this anynonous function , the next & op says argument number 1 ..and as follows
lamda = &(&1 * &2 + &3)
lamda.(2,3,4)
