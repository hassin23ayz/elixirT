defmodule Todo.Database do
  @pool_size 3
  @db_folder "./persist"

  def start_link() do
    File.mkdir_p!(@db_folder)

    # This Module itself acts as a supervisor. it's children processes are Todo.DatabaseWorker type
    children = Enum.map(1..@pool_size, &worker_spec/1)
    Supervisor.start_link(children, strategy: :one_for_one)
  end

  defp worker_spec(worker_id) do
    default_worker_spec = {Todo.DatabaseWorker, {@db_folder, worker_id}}
    Supervisor.child_spec(default_worker_spec, id: worker_id)           # reply by child type
  end

  # this definition is needed for This module aka Todo.Database so that it can be a child when Supervisor.start_link() is called from Todo.System
  def child_spec(_) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, []},
      type: :supervisor        # this module's type
    }
  end

  def store(key, data) do
    key
    |> choose_worker()
    |> Todo.DatabaseWorker.store(key, data)
  end

  def get(key) do
    key
    |> choose_worker()
    |> Todo.DatabaseWorker.get(key)
  end

  defp choose_worker(key) do
    :erlang.phash2(key, @pool_size) + 1
  end

end
