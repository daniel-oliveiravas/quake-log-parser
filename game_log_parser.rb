require 'set'

class GameLogParser

  def initialize(log_file_path)
    @log_file = File.new(log_file_path)
    @players = Set.new
    @kill_by_player = Hash.new(0)
  end

  def parse_log_file
    @log_file.each do |line|
      kill_action = line.match('.*:\s+(.*)\s+killed\s+(.*)\s+by\s+(.*)')
      next if kill_action.nil?

      killer, dead, death_type = kill_action.captures
      if is_player?(killer)
        add_player_to_list(killer)
        @kill_by_player[killer] += 1
      else
        @kill_by_player[dead] -= 1
      end

      add_player_to_list(dead)
    end

    print_result
  end

  private

  def is_player?(player)
    player != '<world>'
  end

  def add_player_to_list(player)
    @players.add(player) if is_player?(player)
  end

  def total_kills
    @kill_by_player.values.inject(:+)
  end

  def print_result
    result = { total_kills: total_kills,
               players: @players.to_a,
               kills: @kill_by_player }
    puts result
  end
end

log_file_path = Dir.pwd + '/log_sample/games.log'
GameLogParser.new(log_file_path).parse_log_file