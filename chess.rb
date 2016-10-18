require_relative 'board'
require_relative 'display'
require_relative 'human_player'
require_relative 'computer_player'
require 'byebug'

class ChessError < StandardError
end

class ChessGame
  attr_accessor :board, :player1, :player2, :current_player, :display

  def initialize(board, player1, player2)
    @board = Board.new
    @player1, @player2 = player1, player2
    @player1.color = :white
    @player2.color = :black
    @current_player = @player1
    @display = Display.new(@board, true)
  end

  def play
    until board.checkmate?(@current_player.color)
      system("clear")
      from_pos, to_pos = @current_player.play_turn(display)
      made_move = board.move(from_pos, to_pos, current_player.color)
      swap_turn if made_move
    end
    system("clear")
    @display.render
    puts "#{@current_player.name} is in checkmate!"
    swap_turn
    puts "#{@current_player.name} wins!"
  end

  private

  def swap_turn
    @current_player = (@current_player == @player1 ? @player2 : @player1)
  end

end


p1 = HumanPlayer.new("Player 1")
p2 = HumanPlayer.new("Player 2")
cp = ComputerPlayer.new("Computer Player 1")
b = Board.new
g = ChessGame.new(b, p1, p2)
g.play
