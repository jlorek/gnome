defmodule TextClient.State do
  defstruct(
    game_service: nil,
    tally: nil,
    guess: "",
    player: :human
  )
end
