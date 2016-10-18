require_relative 'piece'

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
    capture_deltas = @color == :white ? [[-1,-1], [-1,1]] : [[1,-1], [1,1]]
    opposite_color = @color == :white ? :black : :white
    capture_deltas.each do |dx, dy|
      new_x = x + dx
      new_y = y + dy
      next unless Board.in_bounds?([new_x, new_y])
      if @board[[new_x, new_y]].color == opposite_color
        possible_moves << [new_x, new_y]
      end
    end

    if has_moved == false && @color == :white &&
      @board[[x-1, y]].is_a?(NullPiece) && @board[[x-2, y]].is_a?(NullPiece)
      possible_moves << [x-2, y]
    elsif has_moved == false && @color == :black &&
      @board[[x+1, y]].is_a?(NullPiece) && @board[[x+2, y]].is_a?(NullPiece)
      possible_moves << [x+2, y]
    end

    if @color == :white && Board.in_bounds?([x-1, y]) &&
      @board[[x-1, y]].is_a?(NullPiece)
      possible_moves << [x-1, y]
    elsif @color == :black && Board.in_bounds?([x+1, y]) &&
      @board[[x+1, y]].is_a?(NullPiece)
      possible_moves << [x+1, y]
    end

    possible_moves
  end
end
