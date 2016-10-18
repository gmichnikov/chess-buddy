require_relative '../piece'

class SlidingPiece < Piece

  HORIZ_VERT_MOVES = { left: [-1, 0], right: [1, 0], up: [0, -1], down: [0, 1] }
  DIAGONAL_MOVES = { up_left: [-1, -1], up_right: [1, -1], down_left: [-1, 1], down_right: [1, 1] }

  def moves
    possible_moves = []
    if move_dirs[:horiz_and_vert]
      HORIZ_VERT_MOVES.each { | _, (dx, dy) | possible_moves += eval_moves(dx, dy) }
    end

    if move_dirs[:diagonal]
      DIAGONAL_MOVES.each { | _, (dx, dy) | possible_moves += eval_moves(dx, dy) }
    end
    possible_moves
  end

  private

  def eval_moves(dx, dy)
    allowed_moves = []
    next_pos = slide(pos, dx, dy)
    while Board.in_bounds?(next_pos)
      if square_is_empty?(next_pos)
        allowed_moves << next_pos
        next_pos = slide(next_pos, dx, dy)
      elsif square_contains_own_piece?(next_pos)
        break
      elsif square_contains_opponent_piece?(next_pos)
        allowed_moves << next_pos
        break
      end
    end
    allowed_moves
  end

  def square_is_empty?(pos)
    self.board[pos].is_a?(NullPiece)
  end

  def square_contains_own_piece?(pos)
    self.board[pos].color == self.color
  end

  def square_contains_opponent_piece?(pos)
    self.board[pos].color != self.color
  end


  def slide(pos, dx, dy)
    [pos[0] + dx, pos[1] + dy]
  end

end
