require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display

  BCOLOR1 = :cyan
  BCOLOR2 = :magenta
  CURSOR_BCOLOR = :yellow
  CURSOR_COLOR = :blue

  attr_accessor :cursor, :board

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render(possible_destinations = [])
    self.board.rows.each_with_index do |row, r_index|
      row.each_with_index do |square, c_index|
        if self.cursor.cursor_pos == [r_index, c_index]
          print "#{square} ".colorize(:color => CURSOR_COLOR, :background => CURSOR_BCOLOR).blink
        elsif possible_destinations.include?([r_index, c_index])
          print "#{square} ".colorize(:background => CURSOR_COLOR)
        elsif (r_index + c_index).even? && square.color.nil?
          print "#{square} ".colorize(:background => BCOLOR1)
        elsif (r_index + c_index).odd? && square.color.nil?
          print "#{square} ".colorize(:background => BCOLOR2)
        elsif (r_index + c_index).even? && square.color == :black
          print "#{square} ".colorize(:color => :black, :background => BCOLOR1)
        elsif (r_index + c_index).even? && square.color == :white
          print "#{square} ".colorize(:color => :white, :background => BCOLOR1)
        elsif (r_index + c_index).odd? && square.color == :black
          print "#{square} ".colorize(:color => :black, :background => BCOLOR2)
        elsif (r_index + c_index).odd? && square.color == :white
          print "#{square} ".colorize(:color => :white, :background => BCOLOR2)
        end

      end
      puts
    end
  end


end
