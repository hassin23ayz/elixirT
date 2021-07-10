# Ch09_01SuperviseDatabase

> if all the process/GenServer are linked together then an error in one of the processes will make the total system crash
  and SuperVisor will restart it . But supervisor can also isolate error effects  

> restarting the whole system and leaving behind all dangling processes is a correct error handling approach but 
such a recovery approach is too coarse 

> isolation of error allows other parts of the system to run and provide service to while you are recovering 
from the error . this makes the system more available to its clients

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ch09_01_supervise_database` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ch09_01_supervise_database, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ch09_01_supervise_database](https://hexdocs.pm/ch09_01_supervise_database).

