require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display

  P1COLOR = :red
  P2COLOR = :black
  BCOLOR1 = :green
  BCOLOR2 = :light_white
  CURSOR_COLOR = :yellow
  POSSIBLE_MOVE_COLOR = :blue

  attr_accessor :cursor, :board

  def initialize(board)
    @board = board
    @cursor = Cursor.new([7,4], board)
  end

  def render(possible_destinations = [])
    puts "\n  a b c d e f g h"
    self.board.rows.each_with_index do |row, r_index|
      print "#{8 - r_index} "
      row.each_with_index do |piece, c_index|
        pos = [r_index, c_index]
        background_color = determine_background_color(pos)
        color = determine_color(piece)

        if contains_cursor?(pos)
          print "#{piece} ".colorize(:color => color, :background => CURSOR_COLOR).blink
        elsif possible_destinations.include?(pos)
          print "#{piece} ".colorize(:color => color, :background => POSSIBLE_MOVE_COLOR)
        else
          print "#{piece} ".colorize(:color => color, :background => background_color)
        end

      end
      puts
    end
  end

  private

  def determine_background_color(pos)
    (pos[0] + pos[1]).even? ? BCOLOR1 : BCOLOR2
  end

  def determine_color(piece)
    piece.color == :white ? P1COLOR : P2COLOR
  end

  def contains_cursor?(pos)
    self.cursor.cursor_pos == pos
  end


end
