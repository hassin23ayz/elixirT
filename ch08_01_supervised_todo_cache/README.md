# Ch08_01SupervisedTodoCache

A supervisor is a generic process that manages the lifecycle of other processes in a system 
A supervisor process can start other processes [childrens] 
supervisor uses links , monitors & exit traps 
processes that are not supervisors are called workers : provides actual services of the system
you need atleast one supervisor process in the system 
if a supervisor process terminates, the children are also taken down 
------------------
< proper error recovery approach > 
you can detect error in any part of the system and recover from it without leaving behind dangling processes by linking all the processes

< supervisor limit>
A Supervisor won't restart a child process forever , The maximum restart frequency is three restarts in 5 seconds. After the maximum restart frequency was exceeded , the supervisor gave up and terminated , taking down all the child processes with it 

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ch08_01_supervised_todo_cache` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ch08_01_supervised_todo_cache, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ch08_01_supervised_todo_cache](https://hexdocs.pm/ch08_01_supervised_todo_cache).

