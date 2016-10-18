require_relative '../board'
require 'singleton'

class NullPiece
  include Singleton

  def color
    nil
  end

  def to_s
    " "
  end

  def valid_moves
    []
  end

end
