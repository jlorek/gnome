defmodule Dictionary.WordList do
  @me __MODULE__
  def start_link() do
    Agent.start_link(&word_list/0, name: @me)
  end

  def word_list do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    # |> IO.inspect(label: "Dictionary file")
    |> File.read!()
    |> String.split(~r/\n/)
  end

  def random_word() do
    # if :rand.uniform < 0.33 do
    #   Agent.get(@me, fn _ -> exit(:bye) end)
    # end
    Agent.get(@me, &Enum.random/1)
  end
end
