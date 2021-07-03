defmodule Todo.DatabaseWorker do
  use GenServer

  def start(folder_name) do
    GenServer.start(__MODULE__, folder_name)
  end

  def store(pid, key, data) do
    GenServer.cast(pid, {:store, key, data})
  end

  def get(pid, key) do
    GenServer.call(pid, {:get, key})
  end

  @impl GenServer
  def init(folder_name) do
    {:ok, folder_name}
  end

  @impl GenServer
  def handle_cast({:store, key, data}, folder_name) do
    folder_name
    |> file_name(key)
    |> File.write!(:erlang.term_to_binary(data))

    {:noreply, folder_name}
  end

  @impl GenServer
  def handle_call({:get, key}, _ , folder_name) do
    data =
      case File.read(file_name(folder_name, key)) do
        {:ok, contents} ->
          :erlang.binary_to_term(contents)

        # _ ->
        #   nil

        {:error, :enoent} ->
          folder_name
          |> file_name(key)
          |> File.write!(:erlang.term_to_binary([]))
          nil
      end
    {:reply, data, folder_name}
  end

  defp file_name(db_folder, key) do
    Path.join(db_folder, to_string(key))
  end

end
