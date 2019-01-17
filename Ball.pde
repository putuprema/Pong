class Ball {
  PVector pos; // position
  PVector vel; // velocity
  //PVector acc; // acceleration
  
  float bounceAngle, collisionPos, bounceSpeed;
  
  Ball(float startPosX, float startPosY, float startVelX, float startVelY) {
    pos = new PVector(startPosX,startPosY); // position attribute for Ball class
    vel = new PVector(startVelX,startVelY); // velocity attribute for Ball class
    //acc = new PVector(5,5);
  }
  
  void move() {
    // If the ball went pass window boundary, consider the ball dead.
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
    
    // Bounce the ball when it reaches the top/bottom of the screen.
    if (pos.y >= height) {
      vel.y *= -1;
    }
    else if (pos.y <= 0) { 
      vel.y *= -1;
    }
    //vel.add(acc);
    //vel.limit(5);
    pos.add(vel); // Add velocity to the object to it changes position.
  }
  
  void checkCollisionPlayer() {
    // If the ball touches the player paddle, bounce it on the opposite direction.
    if ((pos.x >= playerPaddle.pos.x+15 && pos.x-10 <= playerPaddle.pos.x+17) && (pos.y >= playerPaddle.pos.y-10 && pos.y <= playerPaddle.pos.y+102)) {
      collisionPos = pos.y - playerPaddle.pos.y;
      bounceSpeed = setBounceSpeed(); // Set bounce speed based on where the ball touches the paddle (Touching the edges of the paddle will bounce the ball at highest speed
      bounceAngle = map(collisionPos,0,100, PI/-4, PI/4); // Set bounce angle based on where the ball touches the paddle (from -45 to 45 degrees)
      pos.x = playerPaddle.pos.x+32; // Teleport the ball to the side of the paddle to avoid the ball go beyond the paddle bug
      vel = PVector.fromAngle(bounceAngle); // Create velocity vector based on bounce angle.
      vel.setMag(bounceSpeed); // Limit the velocity so it doesn't go to fast.
      //println("Player bounce zone");
    } //else println("");
  }
  
  void checkCollisionEnemy() {
    // If the ball touches the enemy paddle, bounce it on the opposite direction.
    if ((pos.x+10 >= enemyPaddle.pos.x && pos.x <= enemyPaddle.pos.x) && (pos.y >= enemyPaddle.pos.y-10 && pos.y <= enemyPaddle.pos.y+102)) {
      collisionPos = pos.y - enemyPaddle.pos.y;
      bounceSpeed = setBounceSpeed(); // Set bounce speed based on where the ball touches the paddle (Touching the edges of the paddle will bounce the ball at highest speed
      bounceAngle = map(collisionPos,0,100, PI/4, PI/-4); // Set bounce angle based on where the ball touches the paddle (from 45 to -45 degrees)
      pos.x = enemyPaddle.pos.x-16; // Teleport the ball to the side of the paddle to avoid the ball go beyond the paddle bug
      vel = PVector.fromAngle(bounceAngle); // Create velocity vector based on bounce angle.
      vel.setMag(bounceSpeed*-1); // Limit the velocity so it doesn't go to fast.
      //println("Enemy bounce zone");
    } //else println("");
  }
  
  float setBounceSpeed() { // Set bounce speed. Touching the edges of the paddle result in fastest bounce speed.
      if (collisionPos <= 20 || collisionPos >= 80) return 14;
      else return 9;   
  }
  
  void display() { // Display the ball on screen.
    fill(255);
    ellipse(pos.x,pos.y,20,20); 
  }
}
