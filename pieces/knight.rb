require_relative 'stepping_piece'

class Knight < SteppingPiece
  def initialize(color, board, pos)
    super(color, board, pos)
    @value = 3
  end
  
  def deltas
    [[-1,-2], [-1,2], [1,2], [1,-2], [2,1], [2,-1], [-2,-1], [-2,1]]
  end

  def to_s
    color == :white ? "♞" : "♞" #♘
  end
end
