Paddle playerPaddle;
Paddle enemyPaddle;
Ball pong;
Score score;

boolean playerDead, enemyDead;
int debug=1;

void setup() {
  size(640,480,P2D);
  frameRate(60);
  playerPaddle = new Paddle(30,height/2);
  enemyPaddle = new Paddle(width-30, height/2-100);
  pong = new Ball(width/2-10,height-10,-5,-5);
  score = new Score();
}

void draw() {
  background(0);
  display();
  update();
}

void update() {
  if (keyPressed) {
    //println(key);
    playerPaddle.checkBoundary();
    playerPaddle.move();
  }
  //enemyPaddle.pos.x = mouseX;
  //enemyPaddle.pos.y = mouseY;
  
  // Enemy paddle AI routine
  enemyPaddle.checkBoundary();
  enemyPaddle.moveAI();
  
  pong.move();
  //pong.pos.x = mouseX;
  //pong.pos.y = mouseY;
  pong.checkCollisionPlayer();
  pong.checkCollisionEnemy();
  
  if (playerDead == true) {
    pong = new Ball(width/2+10,height-10,5,-5);
    scoring();
    playerDead = false;
  } else if (enemyDead == true) {
    pong = new Ball(width/2-10,height-10,-5,-5);
    scoring();
    enemyDead = false;
  }  
}

void display() {
  drawCenterLine();  
  playerPaddle.display();
  enemyPaddle.display(); 
  pong.display();
  score.display();
  if (debug == 1) debug();
}

void scoring() {
  if (playerDead && !enemyDead) {
    score.enemy++;
    println("enemy score: ",score.enemy);
  }
  else if (!playerDead && enemyDead) {
    score.player++;
    println("player score: ",score.player);
  }
}

void keyReleased() {
  //println("key ", key, "released");
  key = 0;
}

void keyPressed() {
  //println("key ", key, "pressed");
  if (key == 'l') debug *= -1;
}

void debug() {
  textAlign(LEFT);
  textSize(20);
  text("Bounce angle:", 10, height-70);
  text(pong.bounceAngle*57.295779513, 150, height-70);
  text("Pong hit position:", 10, height-50);
  text(pong.collisionPos, 180, height-50);
  text("x-axis velocity:", 10, height-30);
  text(pong.vel.x, 170, height-30);
  text("y-axis velocity:", 10, height-10);
  text(pong.vel.y, 170, height-10);  
}

void drawCenterLine() {
  stroke(255);
  strokeWeight(3);
  line(width/2,0,width/2,height);
  strokeWeight(1);  
}
