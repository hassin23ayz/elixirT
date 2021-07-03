# Ch07_03TodoPooling

> in ch07_02_todo_persistable project we have done the following 

multiple_clients(n) --[uses]--> Todo.Cache(1)    --[starts]--> Todo.Server(n) 
multiple_clients(n) --[uses]--> Todo.Server(n)
Todo.Server(n)      --[uses]--> Todo.Database(1)

As Todo.Database(1) is of type singleton
The Todo.Database(1) GenServer process receives requests sequentially one at a time from mailbox
so if multiple clients operates simulataneously then the system response 
will be slow as due to the actual DISK IO process being sequential 

> one alternative to the above can be the following
spawn the DISK IO operation of the Todo.Database(1) and make it concurrent 
but doing so will make a lot of Disk IO operation thereby overloading the system 

so in total we are faced with 2 kinds of problems 
1. if Todo.Database(1) DISK IO are sequential then Application response time is slow but DISK ops are healthy 
2. if Todo.Database(1) DISK IO are parallel(spawned) then Application response time is fast but DISK ops can be overloaded & risky

the ideal solution is to intoduce pooling 
> create 3 worker processes under the Todo.Database module 
> keep concurrency but in a controlled manner 
> there should be per-key (todo list name) synchonization. 
  Data with the same key must be treated by the same worker 

  

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ch07_03_todo_pooling` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ch07_03_todo_pooling, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ch07_03_todo_pooling](https://hexdocs.pm/ch07_03_todo_pooling).

