defmodule Dictionary.WordList do
  def start do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    # |> IO.inspect(label: "Dictionary file")
    |> File.read!()
    |> String.split(~r/\n/)
  end

  def random_word(word_list) do
    word_list
    |> Enum.random()
  end
end
