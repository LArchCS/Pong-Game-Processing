// Pong Game
// Starter Code

// how to win:
// survive for 60 seconds without losing a ball
// how to lose:
// lose all 5 balls

// controls:
// first player use left and right arrow, or use mouse
// second player use ctrl and alt, or use mouse

// Features:
//  1. multi-ball mode
//  2. two-player mode
//  3. background music, press UP to turn on/off
//  4. balls random colors
//  5. real gravity, press DOWN to turn on/off
//  6. mouse control for players
//  7. press shift to switch background setting

import java.util.*;
import processing.sound.*;

boolean gravityMode;
boolean twoPlayerMode;
boolean colorMode;
boolean mouseControl_1;
boolean mouseControl_2;
boolean bgMode;
int background;
int ballNum;
float amp;
PImage bg;
Ball[] balls;
Paddle paddle;
Paddle paddle_2;
Headsup hup;
SoundFile bounce;
SoundFile lostBall;
SoundFile lostGame;
SoundFile backMusic;

void setup() {
  // game settings
  ballNum = 1;  // how many balls to play
  bgMode = true;  // turn on the music
  gravityMode = true;  // turn on gravity
  twoPlayerMode = true;  // turn on two players
  mouseControl_1 = false;  // turn on mouse control for player 1
  mouseControl_2 = true;  // turn on mouse control for player 2
  colorMode = true;  // turn on random colors for balls
  // render background
  size(300, 600);
  bg = loadImage("bg.jpg");
  background = 255;
  // set up objects
  hup = new Headsup();
  paddle = new Paddle();
  if (twoPlayerMode) paddle_2 = new Paddle();
  balls = new Ball[ballNum];
  for (int i = 0; i < ballNum; i++) {
    balls[i] = new Ball();
  }
  // music settings
  amp = 1;
  bounce = new SoundFile(this, "pong.mp3");
  lostBall = new SoundFile(this, "lostBall.mp3");
  lostGame = new SoundFile(this, "lostgame.mp3");
  backMusic = new SoundFile(this, "Last Light.mp3");
  backMusic.play();
  backMusic.stop();  // here may look strange, it is to fix a bug in loop()
  backMusic.loop();
}

void draw() {
  if (bgMode) {
    background(bg);
  } else {
    background(background);
  }
  hup.draw();
  for (Ball b : balls) {
    b.draw();
    b.update();
  }
  paddle.update();
  paddle.draw();
  if (twoPlayerMode) {
    paddle_2.update();
    paddle_2.draw();
  }
  if (mouseControl_1) paddle.x = mouseX;
  if (twoPlayerMode && mouseControl_2) paddle_2.x = mouseX;
}

void keyPressed() {
  if (key != CODED) return;
  if (!mouseControl_1) {
    if (keyCode == LEFT) {
      paddle.moveLeft();
    } else if (keyCode == RIGHT) {
      paddle.moveRight();
    }
  }
  if (twoPlayerMode && !mouseControl_2) {
    if (keyCode == CONTROL) {
      paddle_2.moveLeft();
    } else if (keyCode == ALT) {
      paddle_2.moveRight();
    }
  }
  if (keyCode == SHIFT) {
    if (background == 0 && !bgMode) {
      background = 255;
    } else if (background == 255 && !bgMode){
      bgMode = true;
    } else {
      bgMode = false;
      background = 0;
    }
  }
  if (keyCode == DOWN) {
    if (gravityMode == true) {
      gravityMode = false;
    } else {
      gravityMode = true;
    }
  }
  if (keyCode == UP) {
    if (amp == 1) {
      amp = 0;
    } else {
      amp = 1;
    }
    backMusic.amp(amp);
  }  
}