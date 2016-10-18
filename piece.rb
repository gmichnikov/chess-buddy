require_relative 'board'
require 'byebug'

class Piece

  attr_reader :color, :value
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
    moves.reject { |move| puts_self_in_check?(move) }
  end

  def puts_opponent_in_check?(to_pos)
    opponent_color = (color == :white ? :black : :white)
    dup_board = board.dup
    dup_board.move!(pos, to_pos)
    dup_board.in_check?(opponent_color)
  end


  private

  def puts_self_in_check?(to_pos)
    dup_board = board.dup
    dup_board.move!(pos, to_pos)
    dup_board.in_check?(color)
  end

  def square_contains_own_piece?(pos)
    self.board[pos].color == self.color
  end

  def square_contains_opponent_piece?(pos)
    self.board.occupied?(pos) && self.board[pos].color != self.color
  end

  def move_piece_once(pos, dx, dy)
    [pos[0] + dx, pos[1] + dy]
  end

  def legal_destination?(pos)
    Board.in_bounds?(pos) && !square_contains_own_piece?(pos)
  end

  def legal_capture?(pos)
    Board.in_bounds?(pos) && square_contains_opponent_piece?(pos)
  end


end
