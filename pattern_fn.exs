fn_road = fn
  %{name: name, dir: "right"} -> "you #{name} took the right path"
  %{name: name, dir: "left"}  -> "you #{name} took the left path"
  %{}                       -> "hey unknown user take left or right path"
  _                         -> "error"
end

IO.puts(fn_road.(  %{:name=>"Bob", :dir=> "right"}  ))
IO.puts(fn_road.(  %{}  ))
IO.puts(fn_road.(  {}  ))


