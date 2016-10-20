require_relative 'piece'

class SteppingPiece < Piece
  def moves
    x, y = pos
    possible_moves = []
    deltas.each do |dx, dy|
      new_pos = [x + dx, y + dy]
      if legal_destination?(new_pos)
        possible_moves << new_pos
      end
    end
    possible_moves
  end

  alias_method :moves_that_could_capture, :moves

end
