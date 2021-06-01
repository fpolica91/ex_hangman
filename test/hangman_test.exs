defmodule HangmanTest do
  use ExUnit.Case
  alias Hangman.Game
  doctest Hangman

  describe "new_game" do
    test "starts a game" do
      assert %Hangman.Game{} = Hangman.new_game()
    end

    test "letters are all lowercase" do
      game = Hangman.new_game()

      response =
        game.letters
        |> Enum.any?(fn x -> x =~ ~r/^\p{Lu}$/u end)

      assert response == false
    end
  end

  test "state is not changed for :won or :lost" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert {^game, _} = Game.make_move(game, "x")
    end
  end
end
