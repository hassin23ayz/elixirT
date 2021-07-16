# Ch10_04EtsKeyValue

https://www.youtube.com/watch?v=Clm_NhWI0hY
https://www.youtube.com/watch?v=me4cANg9RMU

-ETS = Erlang Term Storage 
-ETS is a mechanism that allows you to share some state between multiple processes in a more efficient way
Typical situations where ETS tables can be useful are shared key/value structures and counters . 
Although these situations can also be implemented with GenServer , such solutions might lead to 
performance and scalability issues .The problem isn’t the many processes running in the system, but the single process on which many
other processes depend.

-ETS table is a separate memory-data structure where you can store tuples  
-via ETS table system wide state can be shared
-An ETS table is identified by its ID 
-ETS tables are mutable 
-Multiple processes can safely write to the same row of the same table . The last write wins 
-Any data coming in or out from ETS is deep copied 
-The process that creates an ETS table is the owner of it . 
-other than owner process termination , there is no automatic garbage collection of an ETS table 
-in Beam , ETS tables are powered by C code , which ensures better speed and efficiency 
-Each row is an arbitrarily sized tuple (with at least one element)
-the element can be any Erlang term, including deep hierarchy of nested lists, tuples, maps or anything else you can store in a variable 
-By default ETS tables are of set type: meaning you can't store multiple tuples with the same key 

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ch10_04_ets_key_value` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ch10_04_ets_key_value, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ch10_04_ets_key_value](https://hexdocs.pm/ch10_04_ets_key_value).

