class Paddle {
  float x;
  float y;
  float w;
  float h;

  Paddle() {
    x = 115;
    y = height * .93;
    w = 75;
    h = 12;
  }

  void draw() {
    if (bgMode) fill(0, 220);
    else fill(0);
    stroke(255);
    rect(x, y, w, h);
  }

  void update() {
    // the keyboard control works better in starter
    int movement = 0;
    if (keyCode == LEFT && paddle.x >= -paddle.w/2) {
      paddle.x = paddle.x - movement;
    } else if (keyCode == RIGHT && paddle.x <= width - paddle.w/2) {
      paddle.x = paddle.x + movement;
    }
  }
  
  void moveLeft() {
    x = x - w;
    if (x <= -w) {
      x = width - w / 2;
    }
  }
  
  void moveRight() {
    x = x + w;
    if (x >= 300) {
      x = - w / 2;
    }
  }
}