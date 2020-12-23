for a <- 1..100, b <- 1..100, c <- 1..100, c > a, c > b, a*a + b*b == c*c, do: {a, b, c}
|> IO.inspect(label: "triple")

triples = for a <- 1..100, b <- 1..100, c <- 1..100, c > a, c > b, a*a + b*b == c*c, do: {a, b, c}
IO.puts "Num triples = #{length(triples)}"

{ ms, _result } = :timer.tc(fn ->
  for a <- 1..100, b <- 1..100, c <- 1..100, c > a, c > b, a*a + b*b == c*c, do: {a, b, c}
end)
IO.puts "#{ms}ms"

# why?
# iex(77)> for a <- 1..3, b <- 1..3, into: %{}, do: {a,b}
# %{1 => 3, 2 => 3, 3 => 3}
# iex(78)> for a <- 1..3, b <- 1..3, into: [], do: {a,b}
# [{1, 1}, {1, 2}, {1, 3}, {2, 1}, {2, 2}, {2, 3}, {3, 1}, {3, 2}, {3, 3}]
# keys in maps will be overwritten, last value for b 'wins'
