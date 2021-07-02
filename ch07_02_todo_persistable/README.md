# Ch07_02TodoPersistable

via Cache module, client code can create multiple users 
All these users are actually a GenServer / process on its own 
each user server can in turn create multiple todo lists 

we can create a file for each User Server . the data of that User will be written and read back from that file 
so it means User Server will use another Server named database . this server will be Singleton type 

when a User Server is initialized it will read that user list from disk and append the list to a new list (runtime list) 
whenever an is being made to that user server it will add data to ram list and write the list to disk at the same file 

we will use simple disk based persistence , encoding the data into erlang external term format

:erlang.term_to_binary(any_type_data) |> store_to_disk()     #encoded byte sequence 
any_type_data = read_from_disk() |> :erlang.binary_to_term() #decoded byte sequence 

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ch07_02_todo_persistable` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ch07_02_todo_persistable, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ch07_02_todo_persistable](https://hexdocs.pm/ch07_02_todo_persistable).

