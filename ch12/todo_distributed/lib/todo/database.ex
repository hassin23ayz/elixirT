defmodule Todo.Database do

  # this definition is needed for This module aka Todo.Database so that it can be a child when Supervisor.start_link() is called from Todo.System
  # this child_spec inherits :poolboy child specification
  def child_spec(_) do
    db_settings = Application.fetch_env!(:todo_distributed, :database)
    # Node name is used to determine the database folder. This allows us to
    # start multiple nodes from the same folders, and data will not clash.
    [name_prefix, _] = "#{node()}" |> String.split("@")
    db_folder = "#{Keyword.fetch!(db_settings, :folder)}/#{name_prefix}/"

    File.mkdir_p!(db_folder)

    :poolboy.child_spec(
      __MODULE__,                             # child ID ( needed by Supervisor Todo.System )
      [                                       # List (pool options)
        name: {:local, __MODULE__},           # Local Registration
        worker_module: Todo.DatabaseWorker,   # Specifies the module that will power each worker process
        size: Keyword.fetch!(db_settings, :pool_size)  # pool size
      ],
      [db_folder]                            # list of argument passed to each worker's start_link function
    )
  end

  def store(key, data) do
    {_results, bad_nodes} =
      :rpc.multicall(
        __MODULE__,
        :store_local,
        [key, data],
        :timer.seconds(5)
      )

    Enum.each(bad_nodes, &IO.puts("Store failed on node #{&1}"))
    :ok
  end

  def store_local(key, data) do
    :poolboy.transaction(                     # checkout req to pool manager > fetch a single worker
      __MODULE__,                             # registered name of the pool manager (_FP_)
      fn worker_pid -> Todo.DatabaseWorker.store(worker_pid, key, data) end  # Lamba gets fetched worker pid as arg > Lambda gets invoked
    )                                         # after lambda gets finished , worker is returned
  end

  def get(key) do
    :poolboy.transaction(
      __MODULE__,
      fn worker_pid -> Todo.DatabaseWorker.get(worker_pid, key) end
    )
  end
end
