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

  test "first occurrence of letter is not already used" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "second occurrence of letter is already used" do
    game = Game.new_game()
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state != :already_used
    {game, _tally} = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("potatoes")
    {game, _tally} = Game.make_move(game, "p")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "when the word is guessed, game is won" do
    game = Game.new_game("rose")
    {game, _tally} = Game.make_move(game, "r")
    assert game.game_state == :good_guess
    {game, _tally} = Game.make_move(game, "o")
    assert game.game_state == :good_guess
    {game, _tally} = Game.make_move(game, "s")
    assert game.game_state == :good_guess
    {game, _tally} = Game.make_move(game, "e")
    assert game.game_state == :won
    assert game.turns_left == 7
  end
end
