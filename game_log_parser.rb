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
    @kills_by_death_type = Hash.new(0)
    @total_kills = 0
    parse_log_file
  end

  def build_result
    @game_result = { total_kills: @total_kills,
                     players: @players.sort.to_a,
                     kills: sort_hash_by_value(@kills_by_player) }
  end

  def build_kills_by_means
    { kills_by_means: sort_hash_by_value(@kills_by_death_type) }
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
      @kills_by_death_type[death_type] += 1
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

  def sort_hash_by_value(hash)
    hash.sort_by { |k, v| v }.reverse.to_h
  end
end