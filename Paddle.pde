class Paddle {
  PVector pos;
  PVector vel;
  //PVector accel;
  
  boolean mentokAtas=false, mentokBawah=false, isMovingUp=false, isMovingDown=false;
  
  Paddle(int x, int y) {
    pos = new PVector(x,y); // position attribute for Ball class
    vel = new PVector(0,0); // velocity attribute for Ball class
    //accel = new PVector(0,0);
  }
  
  void display() { // Display the paddle on screen.
    fill(255);
    //rectMode(CENTER);
    rect(pos.x,pos.y,15,90); 
  }
  
  void move() { // Player paddle movement
    if (key == 'w') { // MOVE UP
      mentokBawah = false; // This is flag to determine whether or not the paddle is at the bottom of the screen.
      vel.y = -10; 
    } else if (key == 's') { // MOVE DOWN
      mentokAtas = false; // This is flag to determine whether or not the paddle is at the top of the screen.
      vel.y = 10;
    } else if (key != 0) { // Don't move if no key is pressed
      vel.y = 0;
    }
    if (vel.y > 0 && mentokBawah == false) pos.add(vel); // If not at the bottom of the screen then move the paddle based on velocity vector
    else if (vel.y < 0 && mentokAtas == false) pos.add(vel); // If not at the top of the screen then move the paddle based on velocity vector
  }
  
  // Enemy AI routine
  void moveAI() {
    if (pong.pos.y >= pos.y+60 && pong.pos.y <= pos.y+65) { // Stop moving if the ball is within the paddle zone.
      vel.y=0;
      isMovingUp=isMovingDown=false;
    } else if (pong.pos.y <= pos.y && !isMovingDown) { // If the ball is above the paddle then move the paddle UP
      mentokAtas=false;
      isMovingDown=true; isMovingUp=false;
      vel.y = -10;
    } else if (pong.pos.y > pos.y+110 && !isMovingUp) { // If the ball is below the paddle then move the paddle DOWN
      mentokBawah=false;
      isMovingDown=false; isMovingUp=true;
      vel.y = 10;
    }
    
    if (vel.y > 0 && mentokBawah == false) pos.add(vel); // If not at the bottom of the screen then move the paddle based on velocity vector
    else if (vel.y < 0 && mentokAtas == false) pos.add(vel); // If not at the top of the screen then move the paddle based on velocity vector
  }
  
  // Check paddle boundary so it doesn't go beyond the game window
  void checkBoundary() {
    if (pos.y <= 1) mentokAtas = true; // Don't move the paddle further up if it reaches the top of the screen
    else if (pos.y >= height-90) mentokBawah = true; // Don't move the paddle further down if it reaches the bottom of the screen
  }
}
