defmodule Todo.Cache do

  def start_link() do
    IO.puts("Starting to-do cache.")
    # this module acts as a DynamicSupervisor
    DynamicSupervisor.start_link(name: __MODULE__, strategy: :one_for_one)
  end

  # this definition is needed for This module aka Todo.Database so that it can be a child when Supervisor.start_link() is called from Todo.System
  def child_spec(_arg) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, []},
      type: :supervisor            # this module's type
    }
  end

  def server_process(todo_list_name) do
    case start_child(todo_list_name) do
      {:ok, pid} -> pid
      {:error, {:already_started, pid}} -> pid
    end
  end

  # this module acts as dynamic supervisor for Todo.Server processes
  # DynamicSupervisor is similar to Supervisor, but where Supervisor is used to start
  # a predefined list of children, DynamicSupervisor is used to start children on demand
  defp start_child(todo_list_name) do
    # The specification {Todo.Server, todo_list_name} will lead to the invocation of Todo.Server.start_link(todo_list_name).
    # The to-do server will be started as the child of the Todo.Cache supervisor( this module)
    DynamicSupervisor.start_child(__MODULE__, {Todo.Server, todo_list_name})
  end

end
