require_relative 'display'
require_relative 'piece'
require 'byebug'
Dir["./pieces/*"].each {|file| require_relative file }

class Board

  PIECE_IN_COLUMN = { 0 => Rook, 1 => Knight, 2 => Bishop, 3 => Queen, 4 => King, 5 => Bishop, 6 => Knight, 7 => Rook }

  attr_accessor :rows

  def self.in_bounds?(pos)
    x, y = pos
    x.between?(0, 7) && y.between?(0, 7)
  end

  def initialize
    @rows = Array.new(8) { Array.new(8) }
    make_starting_grid
  end

  def move(from_pos, to_pos, current_player_color)
    made_move = false
    begin
      current_piece = self[from_pos]
      check_for_move_errors(current_piece, current_player_color, to_pos)
      move!(from_pos, to_pos)
      made_move = true
    rescue ChessError => e
      puts "#{e.message}.\nPlease try again."
      sleep(1)
    end
    made_move
  end

  def move!(from_pos, to_pos)
    current_piece = self[from_pos]
    current_piece.pos = to_pos
    self[from_pos] = NullPiece.instance
    self[to_pos] = current_piece
    update_pawn(to_pos) if current_piece.is_a?(Pawn)
  end

  def [](pos)
    x, y = pos
    self.rows[x][y]
  end

  def []=(pos, value)
    x, y = pos
    self.rows[x][y] = value
  end

  def dup
    dup_board = Board.new
    dup_board.rows.each_with_index do |row, r_index|
      row.each_with_index do |piece, c_index|
        if self[[r_index, c_index]].is_a?(NullPiece)
          dup_board[[r_index,c_index]] = self[[r_index, c_index]]
        else
          dup_board[[r_index,c_index]] = self[[r_index, c_index]].dup
          dup_board[[r_index, c_index]].board = dup_board
        end
      end
    end
    dup_board
  end


  def checkmate?(color)
    return false unless in_check?(color)
    player_pieces = self.rows.flatten.select {|piece| piece.color == color}
    player_pieces.each do |piece|
      return false if piece.valid_moves.length > 0
    end
    true
  end

  def stalemate?
    remaining_pieces = self.rows.flatten.reject {|piece| piece.is_a?(NullPiece)}
    return true if remaining_pieces.length == 2
    false
  end


  def in_check?(color)
    opponent_color = color == :white ? :black : :white
    king = self.rows.flatten.find { |piece| piece.is_a?(King) &&
      piece.color == color }
    opponent_pieces = self.rows.flatten.select { |piece| piece.color == opponent_color }
    opponent_pieces.any? { |piece| piece.moves.include?(king.pos) }
  end

  def empty?(pos)
    self[pos].is_a?(NullPiece)
  end

  def occupied?(pos)
    !empty?(pos)
  end


  private

  def make_starting_grid
    place_black_pieces
    mark_middle_rows_as_empty
    place_white_pieces
  end

  def place_black_pieces
    (0..7).each { |col| self[[0, col]] = PIECE_IN_COLUMN[col].new(:black, self, [0, col]) }
    (0..7).each { |col| self[[1, col]] = Pawn.new(:black, self, [1, col]) }
  end

  def mark_middle_rows_as_empty
    (2..5).each do |row|
      (0..7).each { |col| self[[row, col]] = NullPiece.instance }
    end
  end

  def place_white_pieces
    (0..7).each { |col| self[[6, col]] = Pawn.new(:white, self, [6, col]) }
    (0..7).each { |col| self[[7, col]] = PIECE_IN_COLUMN[col].new(:white, self, [7, col]) }
  end

  def check_for_move_errors(current_piece, current_player_color, to_pos)
    raise ChessError.new("Starting position is empty") if current_piece.is_a?(NullPiece)
    raise ChessError.new("Cannot move opponent's piece") if current_piece.color != current_player_color
    raise ChessError.new("Cannot move to that position") unless Board.in_bounds?(to_pos)
    if current_piece.valid_moves.include?(to_pos)
    elsif current_piece.moves.include?(to_pos)
      raise ChessError.new("Leaves you in check")
    else
      raise ChessError.new("Invalid move for that piece")
    end
  end

  def update_pawn(to_pos)
    self[to_pos].has_moved = true
    check_pawn_promotion(to_pos)
  end

  def check_pawn_promotion(to_pos)
    current_piece = self[to_pos]
    if current_piece.is_a?(Pawn) && current_piece.color == :white &&
        to_pos[0] == 0
      self[[0,to_pos[1]]] = Queen.new(:white, self, [0,to_pos[1]])
    elsif current_piece.is_a?(Pawn) && current_piece.color == :black &&
        to_pos[0] == 7
      self[[7,to_pos[1]]] = Queen.new(:black, self, [7,to_pos[1]])
    end
  end

end
