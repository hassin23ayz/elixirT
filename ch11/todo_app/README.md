# TodoApp

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `todo_app` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:todo_app, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/todo_app](https://hexdocs.pm/todo_app).

## Usage
$mix new hello_world --sup
$iex -S mix
>Application.started_applications()

-----persistence test
>bobs_list = Todo.Cache.server_process("bobss list")
>Todo.Server.add_entry(bobs_list, %{date: ~D[2021-07-02], title: "Dentist"})
query_entry = Todo.Server.entries(bobs_list, ~D[2021-07-02])

-----process restart test
>cache_pid = Process.whereis(Todo.Cache)
>Process.exit(cache_pid, :kill)
>Process.whereis(Todo.Cache)

-----kill, restart of one Todo.Server process does not impact other
>bobs_list = Todo.Cache.server_process("Bob's list")
>alices_list = Todo.Cache.server_process("Alice's list")
>Process.exit(bobs_list, :kill)
>Todo.Cache.server_process("Bob's list")
>Todo.Cache.server_process("Alice's list")

>Application.stop(:todo_app)
>System.stop()