defmodule Dictionary do
  def random_word do
    word_list()
    |> Enum.random()
  end

  def word_list do
    "../assets/words.txt"
    |> Path.expand(__DIR__)
    #|> IO.inspect(label: "Dictionary file")
    |> File.read!()
    |> String.split(~r/\n/)
  end
end
