defmodule Hangman do
  alias Hangman.Game
  defdelegate game_init, to: Game, as: :new_game

  def new_game() do
    game_init()
  end
end
