require_relative '../piece'

class SlidingPiece < Piece
  def moves
    x, y = pos
    possible_moves = []
    if move_dirs[:horizontal]
      possible_moves += eval_moves(-1, 0)
      possible_moves += eval_moves(1, 0)
      possible_moves += eval_moves(0, -1)
      possible_moves += eval_moves(0, 1)
    end

    if move_dirs[:diagonal]
      possible_moves += eval_moves(-1, -1)
      possible_moves += eval_moves(1, -1)
      possible_moves += eval_moves(-1, 1)
      possible_moves += eval_moves(1, 1)
    end
    possible_moves
  end

  private

  def eval_moves(dx, dy)
    possible_moves = []
    x, y = pos
    new_x = x + dx
    new_y = y + dy
    while Board.in_bounds?([new_x, new_y])
      if @board[[new_x, new_y]].is_a?(NullPiece)
        possible_moves << [new_x, new_y]
        new_x += dx
        new_y += dy
      elsif @board[[new_x, new_y]].color == @color
        break
      else # piece can capture opponent's piece
        possible_moves << [new_x, new_y]
        break
      end
    end
    possible_moves
  end

end
