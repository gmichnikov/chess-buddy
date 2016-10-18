class SteppingPiece < Piece
  def moves
    x, y = pos
    possible_moves = []
    deltas.each do |dx, dy|
      new_x, new_y = x + dx, y + dy
      next unless Board.in_bounds?([new_x, new_y])
      possible_moves << [new_x, new_y] unless @board[[new_x, new_y]].color == @color
    end
    possible_moves
  end
end
