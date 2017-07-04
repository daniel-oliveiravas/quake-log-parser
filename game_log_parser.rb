require 'set'

class GameLogParser

  attr_reader :kills_by_player

  WORLD = '<world>'.freeze
  POINTS_TO_WIN_BY_KILL = 1
  POINTS_TO_LOSE_BY_DEATH = -1

  def initialize(log_file_path)
    @log_file = File.new(log_file_path)
    @players = Set.new
    @kills_by_player = Hash.new(0)
    @total_kills = 0
  end

  def build_result
    parse_log_file
    @game_result = { total_kills: @total_kills,
                     players: @players.sort.to_a,
                     kills: @kills_by_player.sort_by { |k, v| v }.reverse.to_h }
  end

  private

  def parse_log_file
    @log_file.each do |line|
      kill_action = line.match('.*:\s+(.*)\s+killed\s+(.*)\s+by\s+(.*)')
      next if kill_action.nil?

      killer, dead, death_type = kill_action.captures

      next if killer.empty? || dead.empty?

      if world?(killer)
        update_score(dead, POINTS_TO_LOSE_BY_DEATH)
      else
        add_players(killer, dead)
        update_score(killer, POINTS_TO_WIN_BY_KILL)
      end
      @total_kills += 1
    end
  end

  def add_players(killer, dead)
    @players.add(killer)
    @players.add(dead)
  end

  def update_score(player, points)
    @kills_by_player[player] += points
  end

  def world?(actor)
    actor == WORLD
  end
end