require_relative 'stepping_piece'

class King < SteppingPiece
  def initialize(color, board, pos)
    super(color, board, pos)
  end

  def deltas
    [[-1,-1], [-1,0], [-1,1], [0,1], [1,1], [1,0], [1,-1], [0,-1]]
  end

  def to_s
    color == :white ? "♔" : "♔" #♚
  end
end
