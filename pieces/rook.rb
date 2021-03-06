require_relative 'sliding_piece'

class Rook < SlidingPiece

  def initialize(color, board, pos)
    super(color, board, pos)
    @value = 5
  end

  def move_dirs
    { horiz_and_vert_allowed: true, diagonal_allowed: false}
  end

  def to_s
    color == :white ? "♜" : "♜"
    #♖
  end
end
