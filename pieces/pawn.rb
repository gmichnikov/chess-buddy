require_relative 'piece'

class Pawn < Piece

  attr_accessor :has_moved

  def initialize(color, board, pos)
    super(color, board, pos)
    @value = 1
    @has_moved = false
  end

  def to_s
    color == :white ? "♟" : "♟" #♙
  end

  def moves
    possible_moves = []
    possible_moves += capture_moves
    possible_moves << square_two_ahead if pawn_can_move_two?
    possible_moves << square_one_ahead if pawn_can_move_one?
    possible_moves
  end

  def capture_moves
    possible_capture_moves = []
    capture_deltas = self.color == :white ? [[-1,-1], [-1,1]] : [[1,-1], [1,1]]
    capture_deltas.each do |dx, dy|
      new_pos = move_piece_once(pos, dx, dy)
      if legal_capture?(new_pos)
        possible_capture_moves << new_pos
      end
    end
    possible_capture_moves
  end

  alias_method :moves_that_could_capture, :capture_moves

  private

  def pawn_direction
    self.color == :white ? -1 : 1
  end


  def pawn_can_move_two?
    has_moved == false && both_squares_ahead_empty?
  end

  def both_squares_ahead_empty?
    self.board.empty?(square_one_ahead) && self.board.empty?(square_two_ahead)
  end

  def square_one_ahead
    [pos[0] + pawn_direction, pos[1]]
  end

  def square_two_ahead
    [pos[0] + 2 * pawn_direction, pos[1]]
  end

  def pawn_can_move_one?
    Board.in_bounds?(square_one_ahead) && self.board.empty?(square_one_ahead)
  end

end
