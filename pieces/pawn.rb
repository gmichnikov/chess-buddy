require_relative '../piece'

class Pawn < Piece

  attr_accessor :has_moved

  def initialize(color, board, pos)
    super(color, board, pos)
    @has_moved = false
  end

  def to_s
    color == :white ? "♟" : "♟" #♙
  end

  def moves
    x, y = pos
    possible_moves = []
    capture_deltas = self.color == :white ? [[-1,-1], [-1,1]] : [[1,-1], [1,1]]
    opponent_color = self.color == :white ? :black : :white
    capture_deltas.each do |dx, dy|
      new_x = x + dx
      new_y = y + dy
      next unless Board.in_bounds?([new_x, new_y])
      if self.board[[new_x, new_y]].color == opponent_color
        possible_moves << [new_x, new_y]
      end
    end

    if has_moved == false && self.color == :white &&
      self.board[[x-1, y]].is_a?(NullPiece) && self.board[[x-2, y]].is_a?(NullPiece)
      possible_moves << [x-2, y]
    elsif has_moved == false && self.color == :black &&
      self.board[[x+1, y]].is_a?(NullPiece) && self.board[[x+2, y]].is_a?(NullPiece)
      possible_moves << [x+2, y]
    end

    if self.color == :white && Board.in_bounds?([x-1, y]) &&
      self.board[[x-1, y]].is_a?(NullPiece)
      possible_moves << [x-1, y]
    elsif @color == :black && Board.in_bounds?([x+1, y]) &&
      self.board[[x+1, y]].is_a?(NullPiece)
      possible_moves << [x+1, y]
    end

    possible_moves
  end
end
