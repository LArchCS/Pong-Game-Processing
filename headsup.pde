class Headsup {
  int round;
  int time;
  boolean win;
  
  Headsup() {
    round = 5;
    time = 0;
    win = false;
  }
  
  void update() {
    time += 1;
  }
  
  void draw() {
    // draw the game status as a "headsup" display on the gameboard
    update();
    if (bgMode) fill(255, 220);
    else fill(255, 0, 0);
    if (round > 0) {
      if (time / 100 < 60) {
        text("Round: " + round, 20, 20);
        text("Time: " + time / 100, 220, 20);
      } else {
        text("You Win", 20, 20);
        win = true;
      }
    } else {
      text("Game Over", 20, 20);
    }
  }
}