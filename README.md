# Quake Log Parser

Software built to parse the game log from Quake to a better format

### Usage

Create a new ruby file and then put the following code in it:

```ruby
require_relative 'game_log_parser.rb'
require_relative 'game_report.rb'

# You should replace the value of log_file_path with your path to the .log file
log_file_path = Dir.pwd + '/log_sample/games.log'
game = GameLogParser.new(log_file_path)

game_report = GamesReport.new
game_report.add_game(game)
game_report.report
```

In the code above we are creating a object of GameLogParser with the path to the log file. When you create this object, it automatically parse the file and build a hash with all the information. Then, we create a object of GamesReport that controls all GameLogParser objects. We need to add the objects into GamesReport using the method `add_game` and then call the `report` method to get the result of all GameLogParser objects.

Aditionally, you can alter the code to parse multiple log files, using the method `add_games` to add them to the GamesReport object

```ruby
first_game = GameLogParser.new(first_game_log_path)
second_game = GameLogParser.new(second_game_log_path)
GamesReport.new.add_games([first_game, second_game])
```

#### Run

To run the code, just use the command ruby with your the file name that you created:
`ruby your_file_name.rb`

#### Plus - Kills by means

To obtain the data about kills by death type, write a ruby file with the following code:

```ruby
# Just change the value of the variable game_log_path with the path to your file
game_log_path = '/path/to/game.log'
GameLogParser.new(game_log_path).build_kills_by_means
```
