defmodule Dictionary do
  alias Dictionary.WordList

  defdelegate start(), to: WordList

  defdelegate random_word(wordlist), to: WordList
end
