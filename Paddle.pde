class Paddle {
  PVector pos;
  PVector vel;
  //PVector accel;
  
  boolean mentokAtas=false, mentokBawah=false;
  
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
    if (pos.y+20 > pong.pos.y) {
      mentokBawah = false;
      vel.y = -10;
    }
    else if (pos.y+20 < pong.pos.y) {
      mentokAtas = false;
      vel.y = 10;
    }
    
    if (vel.y > 0 && mentokBawah == false) pos.add(vel);
    else if (vel.y < 0 && mentokAtas == false) pos.add(vel);
  }
  
  void checkBoundary() {
    if (pos.y <= 0) mentokAtas = true;
    else if (pos.y >= height-90) mentokBawah = true;
  }
}
