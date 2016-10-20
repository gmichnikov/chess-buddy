require_relative 'board'
require_relative '../display/display'
require_relative 'human_player'
require_relative 'computer_player'

class ChessError < StandardError
end

class Game
  attr_accessor :board, :player1, :player2, :current_player, :display

  def initialize(board, player1, player2)
    @board = Board.new
    @player1, @player2 = player1, player2
    @player1.color = :white
    @player2.color = :black
    @current_player = @player1
    @display = Display.new(@board)
  end

  def play
    until board.checkmate?(self.current_player.color) || board.stalemate?
      system("clear")
      from_pos, to_pos = current_player.play_turn(display)

      made_move = board.move(from_pos, to_pos, current_player.color)
      if made_move
        self.display.most_recent_move = made_move
        swap_turn
      end
    end
    board.stalemate? ? handle_stalemate : handle_checkmate

    play_again?
  end

  private

  def swap_turn
    self.current_player = (self.current_player == self.player1 ? self.player2 : self.player1)
  end

  def handle_checkmate
    system("clear")
    self.display.render
    puts "#{self.current_player.name} is in checkmate!"
    swap_turn
    puts "#{self.current_player.name} wins!"
  end

  def handle_stalemate
    system("clear")
    self.display.render
    puts "The game ends in a stalemate!"
  end

  def play_again?
    puts "Please press enter to continue."
    gets
    response = nil
    until(response && ["y", "n"].include?(response))
      print "Play again? (y/n): "
      input = gets.chomp[0]
      response = input ? input.downcase : nil
      system("clear")
    end
    response == "y"
  end
end
