require_relative 'sliding_piece'

class Queen < SlidingPiece
  def move_dirs
    { horiz_and_vert_allowed: true, diagonal_allowed: true}
  end

  def to_s
    color == :white ? "♛" : "♛" #♕
  end
end
