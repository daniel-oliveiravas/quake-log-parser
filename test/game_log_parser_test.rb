require 'minitest/autorun'
require_relative '../game_log_parser.rb'

class GameLogParserTest < Minitest::Test

  def test_log_file_successfully
    game = GameLogParser.new('resources/correct_game.log')
    expectation = {
        total_kills: 1069,
        players: ['Assasinu Credi', 'Chessus', 'Dono da Bola', 'Isgalamido',
                  'Mal', 'Maluquinho', 'Mocinha', 'Oootsimo', 'UnnamedPlayer',
                  'Zeh'],
        kills: {
            'Isgalamido' => 147,
            'Zeh' => 124,
            'Dono da Bola' => 63,
            'Assasinu Credi' => 111,
            'Oootsimo' => 114,
            'Maluquinho' => 0,
            'Mal' => -3,
            'Chessus' => 33
        }
    }
    result = game.build_result
    assert_equal expectation, result
  end

  def test_log_file_without_player
    game = GameLogParser.new('resources/file_without_player.log')
    expectation = {
        total_kills: 0,
        players: [],
        kills: {}
    }
    result = game.build_result
    assert_equal expectation, result
  end

  def test_log_file_without_player_or_world
    game = GameLogParser.new('resources/file_without_player_or_world.log')
    expectation = {
        total_kills: 0,
        players: [],
        kills: {}
    }
    result = game.build_result
    assert_equal expectation, result
  end
end