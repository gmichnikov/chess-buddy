require_relative 'sliding_piece'

class Bishop < SlidingPiece
  def move_dirs
    { horizontal: false, diagonal: true}
  end

  def to_s
    color == :white ? "♝" : "♝" #♗
  end

end
