defmodule Hangman.Game do
  defstruct(
    turns_left: 7,
    game_state: :initializing,
    letters: []
  )

  def new_game() do
    %__MODULE__{
      letters:
        Dictionary.word_list()
        |> String.codepoints()
    }
  end

  def make_move(game = %{game_state: state}, _guess) when state in [:won, :lost] do
    {game, tally(game)}
  end

  # def make_move(game = %{game_state: :lost}, _guess) do
  #   {game, tally(game)}
  # end

  def tally(game) do
    123
  end
end
