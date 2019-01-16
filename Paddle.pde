class Paddle {
  PVector pos;
  PVector vel;
  //PVector accel;
  
  boolean mentokAtas=false, mentokBawah=false, isMovingUp=false, isMovingDown=false;
  
  Paddle(int x, int y) {
    pos = new PVector(x,y); 
    vel = new PVector(0,0);
    //accel = new PVector(0,0);
  }
  
  void display() {
    fill(255);
    //rectMode(CENTER);
    rect(pos.x,pos.y,15,90); 
  }
  
  void move() {
    if (key == 'w') {
      mentokBawah = false;
      vel.y = -10;
    } else if (key == 's') {
      mentokAtas = false;
      vel.y = 10;
    } else if (key != 0) {
      vel.y = 0;
    }
    if (vel.y > 0 && mentokBawah == false) pos.add(vel);
    else if (vel.y < 0 && mentokAtas == false) pos.add(vel);
  }
  
  void moveAI() {
    if (pong.pos.y >= pos.y+60 && pong.pos.y <= pos.y+65) {
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
    
    if (vel.y > 0 && mentokBawah == false) pos.add(vel);
    else if (vel.y < 0 && mentokAtas == false) pos.add(vel);
  }
  
  void checkBoundary() {
    if (pos.y <= 1) mentokAtas = true;
    else if (pos.y >= height-90) mentokBawah = true;
  }
}
