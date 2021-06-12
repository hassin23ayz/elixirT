# Times and Dates
# A date can be created using ~D sigil
date = ~D[2021-05-28]

# A time can be created using ~T sigil
time = ~T[11:59:23.567667]

# naive version can be created using the ~N sigil
naive_datetime = ~N[2021-05-28 11:59:23.567667]

IO.puts(date.month)
IO.puts(time.second)

IO.puts(naive_datetime.month)
IO.puts(naive_datetime.second)
