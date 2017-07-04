require_relative 'game_log_parser.rb'

class GamesReport

  def initialize
    @games = []
  end

  def add_game(game)
    @games << game
  end

  def add_games(games)
    @games.concat(games)
  end

  def report
    build_result_printing_hash
    build_raking
  end

  private

  def build_result_printing_hash
    @games.each do |game|
      puts game.build_result.hash
    end
  end

  def build_raking
    result = Hash.new(0)
    @games.each do |game|
      result = result.merge(game.kills_by_player) do |key, first_value, second_value|
        first_value + second_value
      end
    end
    puts result
  end
end