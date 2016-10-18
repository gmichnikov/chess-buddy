class Queen < SlidingPiece
  def move_dirs
    { horizontal: true, diagonal: true}
  end

  def to_s
    color == :white ? "♛" : "♛" #♕
  end
end
