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
5. The yellow cursor begins on square e4. You can move it around the board using the arrow keys.
6. When you are ready to select a piece to move, click either space bar or enter.
7. Once you select a piece, Chess Buddy will show you all valid moves for that piece by highlighting them in blue.
8. Navigate to the square where you'd like to move your piece, and press enter again.
9. If you attempt to make an invalid move, Chess Buddy will show you an error message and ask you to try again.

## Features

### Chess Buddy AI
 code snippets

 Technical implementation details for anything worth mentioning
 Anything you had to stop and think about before building

### Class Inheritance
code snippets

Technical implementation details for anything worth mentioning
Anything you had to stop and think about before building

![wireframes](https://github.com/gmichnikov/gm-84-plus/blob/master/wireframes/wireframes.001.jpeg)


### Ideas for Future Development

Features that could be added to future versions of Chess Buddy include:

- Saving/Loading Games
- Stronger AI that recognizes all pieces that are at risk before making any move
