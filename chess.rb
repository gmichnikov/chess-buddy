require_relative 'game'

def get_player(num)
  player_type = nil
  until(player_type && ["h", "c"].include?(player_type))
    system("clear")
    puts "Is Player #{num} (white) Human (H) or Computer (C)?"
    player_type = gets.chomp[0].downcase
    if player_type == "h"
      print "Please enter Player #{num}'s name: "
      player_name = gets.chomp
      player = HumanPlayer.new(player_name)
    elsif player_type == "c"
      player = ComputerPlayer.new("Computer Player #{num}")
    end
    puts "pt #{player_type}"
  end
  player
end

def begin_game
  p1 = get_player(1)
  p2 = get_player(2)
  b = Board.new
  g = Game.new(b, p1, p2)
  play_again = g.play
  begin_game if play_again
end

begin_game
puts "Thank you for playing!"
