require_relative 'sliding_piece'

class Rook < SlidingPiece

  def move_dirs
    { horiz_and_vert: true, diagonal: false}
  end

  def to_s
    color == :white ? "♜" : "♜"
    # ♖
  end
end
