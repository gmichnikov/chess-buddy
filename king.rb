class King < SteppingPiece
  def deltas
    [[-1,-1], [-1,0], [-1,1], [0,1], [1,1], [1,0], [1,-1], [0,-1]]
  end

  def to_s
    color == :white ? "♔" : "♔" #♚
  end
end
