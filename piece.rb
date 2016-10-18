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

class SlidingPiece < Piece
  def moves
    x, y = pos
    possible_moves = []
    if move_dirs[:horizontal]
      possible_moves += eval_moves(-1, 0)
      possible_moves += eval_moves(1, 0)
      possible_moves += eval_moves(0, -1)
      possible_moves += eval_moves(0, 1)
    end

    if move_dirs[:diagonal]
      possible_moves += eval_moves(-1, -1)
      possible_moves += eval_moves(1, -1)
      possible_moves += eval_moves(-1, 1)
      possible_moves += eval_moves(1, 1)
    end
    possible_moves
  end

  private

  def eval_moves(dx, dy)
    possible_moves = []
    x, y = pos
    new_x = x + dx
    new_y = y + dy
    while Board.in_bounds?([new_x, new_y])
      if @board[[new_x, new_y]].is_a?(NullPiece)
        possible_moves << [new_x, new_y]
        new_x += dx
        new_y += dy
      elsif @board[[new_x, new_y]].color == @color
        break
      else # piece can capture opponent's piece
        possible_moves << [new_x, new_y]
        break
      end
    end
    possible_moves
  end

end

class Bishop < SlidingPiece
  def move_dirs
    { horizontal: false, diagonal: true}
  end

  def to_s
    color == :white ? "♝" : "♝" #♗
  end

end

class Rook < SlidingPiece

  def move_dirs
    { horizontal: true, diagonal: false}
  end

  def to_s
    color == :white ? "♜" : "♜"
    # ♖
  end
end

class Queen < SlidingPiece
  def move_dirs
    { horizontal: true, diagonal: true}
  end

  def to_s
    color == :white ? "♛" : "♛" #♕
  end
end

class SteppingPiece < Piece
  def moves
    x, y = pos
    possible_moves = []
    deltas.each do |dx, dy|
      new_x, new_y = x + dx, y + dy
      next unless Board.in_bounds?([new_x, new_y])
      possible_moves << [new_x, new_y] unless @board[[new_x, new_y]].color == @color
    end
    possible_moves
  end
end

class King < SteppingPiece
  def deltas
    [[-1,-1], [-1,0], [-1,1], [0,1], [1,1], [1,0], [1,-1], [0,-1]]
  end

  def to_s
    color == :white ? "♔" : "♔" #♚
  end
end

class Knight < SteppingPiece
  def deltas
    [[-1,-2], [-1,2], [1,2], [1,-2], [2,1], [2,-1], [-2,-1], [-2,1]]
  end

  def to_s
    color == :white ? "♞" : "♞" #♘
  end
end

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
