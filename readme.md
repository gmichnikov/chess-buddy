# Chess Buddy

Chess Buddy is a ruby implementation of Chess. It allows the user(s) to play Human vs. Human or Human vs. Computer. Users can also watch a Computer vs. Computer game play out.

## How to Run the Code

You must have Ruby installed in order to play this game. Once you have Ruby installed:

1. Download the zip file by clicking [here](https://github.com/gmichnikov/chess-buddy/archive/master.zip)
2. Open the zip file. You should see a folder called `chess-buddy-master`
3. Open Terminal, and navigate to the chess-buddy-master directory. It should be in the `Downloads` directory.
  - (If you'd like, you can optionally move the folder elsewhere before completing Step 3)
4. Type the command `bundle install` and press enter. This will ensure that you have the `colorize` gem installed. Colorize is used to color the pieces, the board, and the cursor.
5. Type the command `ruby chess.rb` and press enter to play the game.

## How to Play the Game

To read more about rules of Chess and much more, check out [Wikipedia](https://en.wikipedia.org/wiki/Chess).

#### Note: It may be helpful to zoom in, in order to see the pieces more clearly. To do this, press Command-+ (the command key and the plus/equals key) as many times as desired.

To use Chess Buddy:

1. Click enter when you see the welcome message.
2. Type either H or C to indicate that Player 1 will be either a human or computer player.
  - If you choose human, you will be prompted to enter your name.
3. Repeat the same for Player 2.
4. The game always begins with "white", represented in this game by red pieces.
![screenshot](https://github.com/gmichnikov/chess-buddy/blob/master/first-move.png)
5. The yellow cursor begins on square e4. You can move it around the board using the arrow keys.
6. When you are ready to select a piece to move, click either space bar or enter.
7. Once you select a piece, Chess Buddy will show you all valid moves for that piece by highlighting them in blue.
![screenshot](https://github.com/gmichnikov/chess-buddy/blob/master/valid-moves.png)
8. Navigate to the square where you'd like to move your piece, and press enter again.
9. If you attempt to make an invalid move, Chess Buddy will show you an error message and ask you to try again.
10. Chess Buddy currently supports Pawn Promotion, but not Castling.

## Features

### Chess Buddy AI


### Chess Piece Class Inheritance

Each player has six types of pieces on the board: Rook (2), Knight (2), Bishop (2), Queen (1), King (1), and Pawn (8). While each piece has unique constraints on its movement, these constraints have a lot in common. Rooks can slide horizontally or vertically until they meet another piece, while Bishops can slide diagonally. Queens can slide in all 8 of these directions. Chess Buddy captures (!) these similar movement patterns in a [SlidingPiece class](https://github.com/gmichnikov/chess-buddy/blob/master/pieces/sliding_piece.rb), from which all three pieces inherit.

```ruby
# pieces/sliding_piece.rb

HORIZ_VERT_MOVES = { up: [-1, 0], down: [1, 0], left: [0, -1], right: [0, 1] }
DIAGONAL_MOVES = { up_left: [-1, -1], down_left: [1, -1], up_right: [-1, 1], down_right: [1, 1] }

def moves
  possible_moves = []

  if move_dirs[:horiz_and_vert_allowed]
    HORIZ_VERT_MOVES.each { | _, (dx, dy) | possible_moves += eval_moves(dx, dy) }
  end

  if move_dirs[:diagonal_allowed]
    DIAGONAL_MOVES.each { | _, (dx, dy) | possible_moves += eval_moves(dx, dy) }
  end

  possible_moves
end
```

`Rook`s, `Bishop`s, and `Queen`s share the `moves` method above, which returns an array of all `possible_moves` a given piece can make. It does this by iterating through all of the directions in which each piece is allowed to move and moving the piece as far as possible in each directions.

The differences in movement rules can be found in the hash returned by each piece's `move_dirs` method. Here is the `move_dirs` method for the [Rook](https://github.com/gmichnikov/chess-buddy/blob/master/pieces/rook.rb).

```ruby
# pieces/rook.rb

def move_dirs
  { horiz_and_vert_allowed: true, diagonal_allowed: false }
end
```


### Ideas for Future Development

Features that could be added to future versions of Chess Buddy include:

- Saving/Loading Games
- Stronger AI that recognizes all pieces that are at risk before making any move
