# Quake Log Parser

Software built to parse the game log from Quake to a better format

### Usage

You can write a ruby code like this one:

```ruby
# You should replace the value of log_file_path with your path to the .log file
log_file_path = Dir.pwd + '/log_sample/games.log'
game = GameLogParser.new(log_file_path)

game_report = GamesReport.new
game_report.add_game(game)
game_report.report
```

If you have multiple log files, you can use the method `add_games`

```ruby
first_game = GameLogParser.new(first_game_log_path)
second_game = GameLogParser.new(second_game_log_path)
GamesReport.new.add_games([first_game, second_game])
```

To obtain the data about kills by death type:

```ruby
GameLogParser.new(game_log_path).build_kills_by_means
```
