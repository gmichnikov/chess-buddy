class ComputerPlayer
  attr_reader :name
  attr_accessor :color

  def initialize(name)
    @name = name
  end

  def play_turn(display)
    display.render
    sleep(0.1)
    possible_moves = find_all_computer_moves(display)
    capture_moves = find_computer_captures(possible_moves, display)

    put_in_check_moves = possible_moves.select do |from_pos, to_pos|
      display.board[from_pos].move_opponent_into_check?(to_pos)
    end

    if put_in_check_moves.length > 0
      put_in_check_moves.sample
    elsif capture_moves.length > 0
      capture_moves.sample
    else
      possible_moves.sample
    end
  end

  private

  def find_all_computer_moves(display)
    comp_pieces = display.board.rows.flatten.select { |piece| piece.color == color }
    possible_moves = []
    comp_pieces.each do |piece|
      piece.valid_moves.each do |to_pos|
        possible_moves << [piece.pos, to_pos]
      end
    end
    possible_moves
  end

  def find_computer_captures(possible_moves, display)
    other_color = color == :white ? :black : :white
    possible_captures = display.board.rows.flatten.select { |piece| piece.color == other_color }
    poss_capture_pos = possible_captures.map { |piece| piece.pos }
    capture_moves = possible_moves.select { |from_pos, to_pos| poss_capture_pos.include?(to_pos) }
    capture_moves
  end

end
