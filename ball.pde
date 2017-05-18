class Ball {
  PVector position;
  PVector velocity;
  int r;
  float gravity;
  int initial;
  color c;
  
  Ball() {
    r = 16;
    gravity = 0.4;
    initial = 7;
    c = color(255,0,0);
    if (gravityMode) {
      initial -= 4;
    }
    position = new PVector(width/2, 40);
    randomSpeed();
  }
  
  void update() {
    if (hup.round <= 0 || hup.win) {
      return;
    }
    if (gravityMode) {
      addGravity();
    }
    bounceBoundary();
    bouncePaddle();
    if (lostBall()) {
      if (hup.round > 0) {
        lostBall.play();
      } else {
        lostGame.play();
      }
    }
    position.add(velocity);
  }
  
  void draw() {
    if (bgMode) fill(c, 220);
    else fill(c);
    stroke(255);
    ellipse(position.x, position.y, r, r);
  }
  
  void bounceBoundary() {
    if (position.x > width - r || position.x < r) {
      bounce.play();
      reverseX();
    } else if (position.y < r) {
      bounce.play();
      randomY();
      randomX();
    }
  }
  
  void bouncePaddle() {
    if (twoPlayerMode) {
      if (!colliding(paddle) && !colliding(paddle_2)) {
        return;
      }
    } else if (!colliding(paddle)) {
      return;
    }
    bounce.play();
    reverseY();
    reduceX();
    if (colorMode) newColor();
  }
  
  boolean lostBall() {
    if (position.y <= height || hup.round <= 0) {
      return false;
    }
    hup.round -= 1;
    if (hup.round > 0) {
      position = new PVector(width/2, 40);
      randomSpeed();
      hup.time = 0;
    }
    return true;
  }
  
  void randomSpeed() {
    double x = 5 - (new Random()).nextInt(9);
    velocity = new PVector((int)x, initial);
    randomY();
  }
  
  void reverseX() {
    velocity.x = velocity.x * -1;
  }
  
  void reverseY() {
    velocity.y = velocity.y * -1;
  }
  
  void randomX() {
    velocity.x += 2 - (new Random()).nextInt(5);
  }
  
  void randomY() {
    int temp = (new Random()).nextInt(3);
    velocity.y = initial + temp;
  }
  
  void reduceX() {
    int temp = (new Random()).nextInt(1);
    if (velocity.x > 0) {
      velocity.x -= temp;
    } else {
      velocity.x += temp;
    }
  }
  
  // bouncing calculation
  // http://stackoverflow.com/questions/21089959/detecting-collision-of-rectangle-with-circle
  boolean colliding(Paddle paddle) {
    int distX = Math.abs((int)position.x - (int)paddle.x - (int)paddle.w / 2);
    int distY = Math.abs((int)position.y - (int)paddle.y - (int)paddle.h / 2);
    if (distX > (paddle.w / 2 + r)) { return false; }
    if (distY > (paddle.h / 2 + r)) { return false; }
    if (distX <= (paddle.w / 2)) { return true; } 
    if (distY <= (paddle.h / 2)) { return true; }
    int dx = distX - (int)paddle.w / 2;
    int dy = distY - (int)paddle.h / 2;
    return (dx * dx + dy * dy <= (r * r));
  }
  
  void addGravity() {
    velocity.y += gravity;
  }
  
  void newColor() {
    int r = (new Random()).nextInt(256);
    int g = (new Random()).nextInt(256);
    int b = (new Random()).nextInt(256);
    if (Math.abs(r-g) < 10 && Math.abs(r-b) < 10) {
      r = 255;
      g = 0;
      b = 0;
    }
    c = color(r, g, b);
  }
}
