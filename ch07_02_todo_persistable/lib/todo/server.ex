defmodule Todo.Server do
  use GenServer

  def start(name) do
    GenServer.start(__MODULE__, name) # not a singleton, each user server is separate
  end

  @impl GenServer
  def init(name) do                      # it has to read data from Disk and append to the new list
    {:ok, {name, Todo.Database.get(name) || Todo.List.new()} }
  end

  @impl GenServer
  def handle_cast({:add_entry, new_entry}, {name, todo_list}) do
    new_list = Todo.List.add_entry(todo_list, new_entry)
    Todo.Database.store(name, new_list)
    {:noreply, {name, new_list}}
  end

  @impl GenServer
  def handle_call({:entries, date}, _ , {name, todo_list}) do
    {:reply, Todo.List.entries(todo_list, date), {name, todo_list}}
  end

  def add_entry(pid, new_entry) do
    GenServer.cast(pid , {:add_entry, new_entry}) # 1st arg is not __MODULE__ ,
                                                  # letting multiple instances to be used
  end

  def entries(pid, date) do
    GenServer.call(pid, {:entries, date})         # 1st arg is not __MODULE__ ,
                                                  # letting multiple instances to be used
  end
end
