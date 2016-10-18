require_relative 'board'
require 'singleton'

class NullPiece
  include Singleton

  def moves
  end

  def color
    nil
  end

  def to_s
    " "
  end

  def empty?
  end




end
