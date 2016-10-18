class HumanPlayer

  attr_reader :name
  attr_accessor :color

  def initialize(name)
    @name = name
  end

  def play_turn(display)

    notify_players(display)
    display.render
    while display.cursor.get_input
      system("clear")
      notify_players(display)
      display.render
    end
    from_pos = display.cursor.cursor_pos

    possible_destinations = display.board[from_pos].valid_moves

    system("clear")
    display.render(possible_destinations)
    while display.cursor.get_input
      system("clear")
      display.render(possible_destinations)
    end
    to_pos = display.cursor.cursor_pos

    [from_pos, to_pos]
  end

  private

  def notify_players(display)
    puts "It is #{name}'s turn!"
    if display.board.in_check?(color)
      puts "You are in check!"
    end
  end

end
