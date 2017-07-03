require 'set'

class GameLogParser

  attr_reader :kill_by_player

  def initialize(log_file_path)
    @log_file = File.new(log_file_path)
    @players = Set.new
    @kill_by_player = Hash.new(0)
    @total_kills = 0
  end

  def build_result
    parse_log_file
    @game_result = { total_kills: @total_kills,
                     players: @players.to_a,
                     kills: @kill_by_player }
  end

  private

  def parse_log_file
    @log_file.each do |line|
      kill_action = line.match('.*:\s+(.*)\s+killed\s+(.*)\s+by\s+(.*)')
      next if kill_action.nil?

      killer, dead, death_type = kill_action.captures
      if player?(killer)
        @players.add(killer)
        @kill_by_player[killer] += 1
      else
        @kill_by_player[dead] -= 1
      end

      @players.add(dead)
      @total_kills += 1
    end
  end

  def player?(player)
    player != '<world>'
  end
end