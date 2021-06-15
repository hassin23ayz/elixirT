defmodule MultiDict do
  def new(), do: %{}

  def add(dict, key, value) do
    Map.update(dict, key, [value], fn values -> [value | values] end)
  end

  def get(dict, key) do
    Map.get(dict, key, [])
  end
end

defmodule TodoList do
  def new(), do: MultiDict.new()

  def add_entry(todo_list, entry) do
    MultiDict.add(todo_list, entry.date, entry)
  end

  def entries(todo_list, date) do
    MultiDict.get(todo_list, date)
  end
end

defmodule UParse do
  def conv2map(one_line) do
    #IO.inspect(String.split(one_line, "," , trim: true))
    elems = String.split(one_line, "," , trim: true)
    #IO.inspect(elems)
    m_map = Map.new([{:date, ""}, {:title, ""}])
    m_map = Map.put(m_map, :date,  Enum.at(elems, 0))
    m_map = Map.put(m_map, :title, Enum.at(elems, 1))
    #IO.inspect(m_map)
    m_map
  end
end

lines = File.read!("todos.csv") |> String.split("\n",trim: true)
#IO.inspect(lines)
#nested_list = Enum.map(lines, fn x -> String.split(x, "," , trim: true)  end)
#IO.inspect(nested_list)

#IO.inspect(Enum.map(lines, fn each_line-> UParse.conv2map(each_line) end))

maps_of_file = Enum.map(lines, fn each_line-> UParse.conv2map(each_line) end)
IO.inspect(maps_of_file)

mtodo_list = TodoList.new()
mtodo_list = Enum.map(maps_of_file, fn each_map -> TodoList.add_entry(mtodo_list, each_map) end)

IO.inspect(mtodo_list)

IO.inspect(Enum.map(mtodo_list, fn each_map -> TodoList.entries(each_map, "2018/12/19") end))
