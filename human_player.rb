class HumanPlayer

  attr_reader :name
  attr_accessor :color

  def initialize(name)
    @name = name
  end

  def play_turn(display)
    from_pos = select_piece(display)
    to_pos = select_destination(display, from_pos)
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

  def select_destination(display, from_pos)
    possible_destinations = display.board[from_pos].valid_moves
    system("clear")
    display.render(possible_destinations)
    while display.cursor.get_input
      system("clear")
      display.render(possible_destinations)
    end
    display.cursor.cursor_pos
  end

  def notify_players(display)
    puts "It is #{name}'s turn!"
    if display.board.in_check?(color)
      puts "You are in check!"
    end
    display.render
  end

end
