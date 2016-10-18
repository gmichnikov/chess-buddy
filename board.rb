# require_relative 'chess'
require_relative 'display'
require_relative 'piece'
require_relative 'null_piece'
require 'byebug'

class Board

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
      if current_piece.class == NullPiece
        raise ChessError.new("No piece at starting position")
      end
      if current_piece.color != current_player_color
        raise ChessError.new("Not your piece")
      end

      raise ChessError.new("Cannot move to that position") unless Board.in_bounds?(to_pos)
      unless current_piece.valid_moves.include?(to_pos)
        raise ChessError.new("Invalid move")
      end
      move!(from_pos, to_pos)
      self[to_pos].has_moved = true if self[to_pos].is_a?(Pawn)
      made_move = true
    rescue ChessError => e
      puts e.message
      sleep(1)
    end
    made_move
  end

  def move!(from_pos, to_pos)
    current_piece = self[from_pos]
    current_piece.pos = to_pos
    self[from_pos] = NullPiece.instance
    self[to_pos] = current_piece

    promote_pawns(current_piece, to_pos)
  end

  def [](pos)
    x, y = pos
    @rows[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @rows[x][y] = value
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
    player_pieces = @rows.flatten.select {|piece| piece.color == color}
    player_pieces.each do |piece|
      return false if piece.valid_moves.length > 0
    end
    true
  end

  def in_check?(color)
    other_color = color == :white ? :black : :white
    king = @rows.flatten.select { |piece| piece.is_a?(King) &&
      piece.color == color}.first
    opponent_pieces = @rows.flatten.select { |piece| piece.color == other_color }
    opponent_pieces.any? { |piece| piece.moves.include?(king.pos) }
  end




  private

  def make_starting_grid

    self[[0,0]] = Rook.new(:black, self, [0,0])
    self[[0,1]] = Knight.new(:black, self, [0,1])
    self[[0,2]] = Bishop.new(:black, self, [0,2])
    self[[0,3]] = Queen.new(:black, self, [0,3])
    self[[0,4]] = King.new(:black, self, [0,4])
    self[[0,5]] = Bishop.new(:black, self, [0,5])
    self[[0,6]] = Knight.new(:black, self, [0,6])
    self[[0,7]] = Rook.new(:black, self, [0,7])
    @rows.each_with_index do |row, r_index|
      row.each_with_index do |square, c_index|
        if r_index == 0
          next
        elsif r_index == 1
          self[[r_index, c_index]] = Pawn.new(:black, self, [r_index, c_index])
        elsif r_index.between?(2,5)
          self[[r_index, c_index]] = NullPiece.instance
        elsif r_index == 6
          self[[r_index, c_index]] = Pawn.new(:white, self, [r_index, c_index])
        else
        end
      end
    end
    self[[7,0]] = Rook.new(:white, self, [7,0])
    self[[7,1]] = Knight.new(:white, self, [7,1])
    self[[7,2]] = Bishop.new(:white, self, [7,2])
    self[[7,3]] = Queen.new(:white, self, [7,3])
    self[[7,4]] = King.new(:white, self, [7,4])
    self[[7,5]] = Bishop.new(:white, self, [7,5])
    self[[7,6]] = Knight.new(:white, self, [7,6])
    self[[7,7]] = Rook.new(:white, self, [7,7])

  end

  # private

  def promote_pawns(current_piece, to_pos)
    if current_piece.is_a?(Pawn) && current_piece.color == :white &&
        to_pos[0] == 0
      self[[0,to_pos[1]]] = Queen.new(:white, self, [0,to_pos[1]])
    elsif current_piece.is_a?(Pawn) && current_piece.color == :black &&
        to_pos[0] == 7
      self[[7,to_pos[1]]] = Queen.new(:black, self, [7,to_pos[1]])
    end
  end

end
