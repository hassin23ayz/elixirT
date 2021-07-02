defmodule Todo.Database do
  use GenServer

  @db_folder "./persist"                               # this is a module attribute

  def start do
    GenServer.start(__MODULE__, nil, name: __MODULE__) # type is singleton
  end

  @impl GenServer                                      # create the folder if it does not exist
  def init(_) do
    File.mkdir_p!(@db_folder)
    {:ok, nil}                                         # this module has no data storage
  end

  def store(key, data) do
    GenServer.cast(__MODULE__, {:store, key, data})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  @impl GenServer
  def handle_cast({:store, key, data}, state) do         # create separate file for separate user(key) and write data to that file
    key
    |> file_name()
    |> File.write!(:erlang.term_to_binary(data))         # file creating , appending happens internally
    {:noreply, state}
  end

  @impl GenServer
  def handle_call({:get, key}, _ , state) do
    data =
      case File.read(file_name(key)) do
        {:ok, contents} ->                            # if data from file is read then return converted data
          :erlang.binary_to_term(contents)

        # _ ->                                          # in other cases return nil
        #   nil

        {:error, :enoent} ->
          key
          |> file_name()
          |> File.write!(:erlang.term_to_binary([]))
          nil
      end
    {:reply, data, state}
  end

  defp file_name(key) do
    Path.join(@db_folder, to_string(key))
  end

end
