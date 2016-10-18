class Rook < SlidingPiece

  def move_dirs
    { horizontal: true, diagonal: false}
  end

  def to_s
    color == :white ? "♜" : "♜"
    # ♖
  end
end
