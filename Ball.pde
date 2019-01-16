class Ball {
  PVector pos; // position
  PVector vel; // velocity
  PVector acc; // acceleration
  
  float bounceAngle, collisionPos, bounceSpeed;
  
  Ball(float startPosX, float startPosY, float startVelX, float startVelY) {
    pos = new PVector(startPosX,startPosY);
    vel = new PVector(startVelX,startVelY);
    //acc = new PVector(5,5);
  }
  
  void move() {
    if (pos.x >= width+200) {
      //vel.x *= -1;
      vel.limit(0);
      enemyDead = true;
    }
    else if (pos.x <= -200) {
      //vel.x *= -1;
      vel.limit(0);
      playerDead = true;
    }
    
    if (pos.y >= height) {
      vel.y *= -1;
    }
    else if (pos.y <= 0) { 
      vel.y *= -1;
    }
    //vel.add(acc);
    //vel.limit(5);
    pos.add(vel);
  }
  
  void checkCollisionPlayer() {
    if ((pos.x >= playerPaddle.pos.x+15 && pos.x-10 <= playerPaddle.pos.x+17) && (pos.y >= playerPaddle.pos.y-10 && pos.y <= playerPaddle.pos.y+102)) {
      collisionPos = pos.y - playerPaddle.pos.y;
      bounceSpeed = setBounceSpeed();
      bounceAngle = map(collisionPos,0,100, PI/-4, PI/4);
      vel = PVector.fromAngle(bounceAngle);
      vel.setMag(bounceSpeed);
      //println("Player bounce zone");
    } //else println("");
  }
  
  void checkCollisionEnemy() {
    if ((pos.x+10 >= enemyPaddle.pos.x && pos.x <= enemyPaddle.pos.x) && (pos.y >= enemyPaddle.pos.y-10 && pos.y <= enemyPaddle.pos.y+102)) {
      collisionPos = pos.y - enemyPaddle.pos.y;
      bounceSpeed = setBounceSpeed();
      bounceAngle = map(collisionPos,0,100, PI/4, PI/-4);
      vel = PVector.fromAngle(bounceAngle);
      vel.setMag(bounceSpeed*-1);
      //println("Enemy bounce zone");
    } //else println("");
  }
  
  float setBounceSpeed() {
      if (collisionPos <= 20 || collisionPos >= 80) return 14;
      else return 9;   
  }
  
  void display() {
    fill(255);
    ellipse(pos.x,pos.y,20,20); 
  }
}
