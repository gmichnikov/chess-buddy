class ComputerPlayer
  attr_reader :name
  attr_accessor :color

  def initialize(name)
    @name = name
  end

  def play_turn(display)
    display.render
    sleep(0.1)
    possible_moves = find_computer_moves(display)
    capture_moves = find_computer_captures(possible_moves, display)
    safe_moves = find_computer_safe_moves(possible_moves, display)
    valuable_capture_moves = find_valuable_capture_moves(capture_moves, display)

    put_in_check_moves = possible_moves.select do |from_pos, to_pos|
      display.board[from_pos].puts_opponent_in_check?(to_pos)
    end

    safe_put_in_check_moves = safe_moves & put_in_check_moves
    safe_valuable_capture_moves = safe_moves & valuable_capture_moves
    safe_capture_moves = safe_moves & capture_moves

    if safe_valuable_capture_moves.length > 0
      safe_valuable_capture_moves.sample

    elsif safe_put_in_check_moves.length > 0
      safe_put_in_check_moves.sample

    elsif valuable_capture_moves.length > 0
      valuable_capture_moves.sample

    elsif safe_capture_moves.length > 0
      safe_capture_moves.sample

    elsif safe_moves.length > 0
      safe_moves.sample

    elsif put_in_check_moves.length > 0
      put_in_check_moves.sample

    elsif capture_moves.length > 0
      capture_moves.sample

    else
      possible_moves.sample
    end
  end

  private

  def find_computer_moves(display)
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
    opponent_color = color == :white ? :black : :white
    opponent_pieces = display.board.rows.flatten.select { |piece| piece.color == opponent_color }
    opponent_piece_positions = opponent_pieces.map { |piece| piece.pos }
    capture_moves = possible_moves.select { |from_pos, to_pos| opponent_piece_positions.include?(to_pos) }
    capture_moves
  end

  def find_computer_safe_moves(possible_moves, display)
    possible_moves.reject { |from_pos, to_pos| display.board[from_pos].puts_self_at_risk?(to_pos) }
  end

  def find_valuable_capture_moves(capture_moves, display)
    capture_moves.select do |from_pos, to_pos|
      display.board[from_pos].value <= display.board[to_pos].value
    end
  end

end
