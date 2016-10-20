class HumanPlayer

  attr_reader :name
  attr_accessor :color

  def initialize(name)
    @name = name
  end

  def play_turn(display)
    from_pos = select_piece(display)
    possible_destinations = display.board[from_pos].valid_moves
    if illegal_piece_selection(display, from_pos) || possible_destinations.empty?
      to_pos = nil
    else
      to_pos = select_destination(display, from_pos, possible_destinations)
    end
    [from_pos, to_pos]
  end

  private

  def select_piece(display)
    notify_players(display)
    while display.cursor.get_input
      system("clear")
      notify_players(display)
    end
    display.cursor.cursor_pos
  end

  def illegal_piece_selection(display, from_pos)
    display.board.empty?(from_pos) ||
      (display.board.occupied?(from_pos) && display.board[from_pos].color != color)
  end

  def select_destination(display, from_pos, possible_destinations)
    system("clear")
    print_whose_turn(display)
    display.render(possible_destinations)
    while display.cursor.get_input
      system("clear")
      print_whose_turn(display)
      display.render(possible_destinations)
    end
    display.cursor.cursor_pos
  end

  def notify_players(display)
    print_whose_turn(display)
    if display.board.in_check?(color)
      puts "You are in check!"
    end
    display.render
  end

  def print_whose_turn(display)
    puts "It is #{name}'s turn!"
    puts "Most recent move: #{display.most_recent_move}" if display.most_recent_move
  end

end
