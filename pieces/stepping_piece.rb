require_relative '../piece'

class SteppingPiece < Piece
  def moves
    x, y = pos
    possible_moves = []
    deltas.each do |dx, dy|
      new_pos = [x + dx, y + dy]
      if Board.in_bounds?(new_pos) && !square_contains_own_piece?(new_pos)
        possible_moves << new_pos
      end
    end
    possible_moves
  end

  private

  def square_contains_own_piece?(pos)
    self.board[pos].color == self.color
  end
end
