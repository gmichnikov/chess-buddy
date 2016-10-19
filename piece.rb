require_relative 'board'
require_relative 'my_array'
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
    "#{color} piece in spot #{board.translate_pos_to_chess(pos)}"
  end

  def valid_moves
    moves.reject { |move| puts_self_in_check?(move) }
  end

  def valid_moves_that_could_capture
    moves_that_could_capture.reject { |move| puts_self_in_check?(move) }
  end


  def puts_opponent_in_check?(to_pos)
    opponent_color = (color == :white ? :black : :white)
    dup_board = board.dup
    dup_board.move!(pos, to_pos)
    dup_board.in_check?(opponent_color)
  end

  def puts_self_at_risk?(to_pos)
    opponent_color = (color == :white ? :black : :white)
    dup_board = board.dup
    dup_board.move!(pos, to_pos)

    opponent_pieces = dup_board.rows.flatten.select { |piece| piece.color == opponent_color }
    opponent_pieces.each do |opponent_piece|
      opponent_piece.valid_moves_that_could_capture.each do |move|
        return true if move == to_pos
      end
    end

    false
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
