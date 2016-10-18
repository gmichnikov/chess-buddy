require_relative 'board'
require 'byebug'

class Piece

  attr_reader :color
  attr_accessor :pos, :board

  def initialize(color, board, pos)
    @color, @board, @pos = color, board, pos
  end

  def to_s
  end

  def inspect
    "#{color} piece in spot #{pos}"
  end

  def valid_moves
    moves.reject { |move| move_into_check?(move) }
  end

  def move_opponent_into_check?(to_pos)
    other_color = (color == :white ? :black : :white)
    dup_board = board.dup
    dup_board.move!(pos, to_pos)
    dup_board.in_check?(other_color)
  end


  private

  def move_into_check?(to_pos)
    dup_board = board.dup
    dup_board.move!(pos, to_pos)
    dup_board.in_check?(color)
  end

end
