require_relative 'sliding_piece'

class Bishop < SlidingPiece

  def initialize(color, board, pos)
    super(color, board, pos)
    @value = 3
  end

  def move_dirs
    { horiz_and_vert_allowed: false, diagonal_allowed: true}
  end

  def to_s
    color == :white ? "♝" : "♝" #♗
  end

end
