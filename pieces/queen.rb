require_relative 'sliding_piece'

class Queen < SlidingPiece
  def initialize(color, board, pos)
    super(color, board, pos)
    @value = 9
  end

  def move_dirs
    { horiz_and_vert_allowed: true, diagonal_allowed: true}
  end

  def to_s
    color == :white ? "♛" : "♛" #♕
  end
end
