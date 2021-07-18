defmodule TodoApp.Application do
  use Application

  @impl true
  def start(_, _) do
    Todo.System.start_link()
  end
end
