require_relative '../piece'

class SlidingPiece < Piece

  HORIZ_VERT_MOVES = { up: [-1, 0], down: [1, 0], left: [0, -1], right: [0, 1] }
  DIAGONAL_MOVES = { up_left: [-1, -1], down_left: [1, -1], up_right: [-1, 1], down_right: [1, 1] }

  def moves
    possible_moves = []
    if move_dirs[:horiz_and_vert_allowed]
      HORIZ_VERT_MOVES.each { | _, (dx, dy) | possible_moves += eval_moves(dx, dy) }
    end

    if move_dirs[:diagonal_allowed]
      DIAGONAL_MOVES.each { | _, (dx, dy) | possible_moves += eval_moves(dx, dy) }
    end
    possible_moves
  end

  alias_method :moves_that_could_capture, :moves

  private

  def eval_moves(dx, dy)
    allowed_moves = []
    next_pos = move_piece_once(pos, dx, dy)
    while Board.in_bounds?(next_pos)
      if self.board.empty?(next_pos)
        allowed_moves << next_pos
        next_pos = move_piece_once(next_pos, dx, dy)
      elsif square_contains_own_piece?(next_pos)
        break
      elsif square_contains_opponent_piece?(next_pos)
        allowed_moves << next_pos
        break
      end
    end
    allowed_moves
  end

end
