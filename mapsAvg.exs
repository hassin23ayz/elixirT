func_getAvg = fn arg_map1, arg_map2 ->
  (arg_map1[:age] + arg_map2[:age]) / 2
end

map1 = %{:age => 12, :name => "tom"}
map2 = %{:age => 10, :name => "jerry"}

IO.puts(func_getAvg.(map1, map2))
