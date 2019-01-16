Paddle playerPaddle;
Paddle enemyPaddle;
Ball pong;
Score score;
PFont bebas;

boolean playerDead, enemyDead, playerWin, enemyWin, firstRun=true;
int debug=-1;

void setup() {
  size(640,480,P2D);
  frameRate(60);
  playerPaddle = new Paddle(30,height/2);
  enemyPaddle = new Paddle(width-45, height/2-100);
  pong = new Ball(width/2-10,height-10,-5,-5);
  score = new Score();
  bebas = createFont("fonts/BebasNeue.ttf",300,false);
}

void draw() {
  background(0);
  textFont(bebas);
  if (firstRun) {
    displayMainMenu();
  } else {
    display();
    update();
  }
}

void update() {
  playerPaddle.checkBoundary();
  if (keyPressed) {
    //println(key);
    playerPaddle.move();
  }
  //enemyPaddle.pos.x = mouseX;w
  //enemyPaddle.pos.y = mouseY;
  
  // Enemy paddle AI routine
  enemyPaddle.checkBoundary();
  if (!playerWin && !enemyWin) enemyPaddle.moveAI();
  //playerPaddle.moveAI(); // AI Player Mode
  
  //pong.pos.x = mouseX;
  //pong.pos.y = mouseY;
  if (pong.pos.x > width/2) pong.checkCollisionEnemy();
  else pong.checkCollisionPlayer();
  pong.move();
  
  if (playerDead == true) {
    if (!enemyWin) {
      scoring();
      checkWin();
    }
  } else if (enemyDead == true) {
    if (!playerWin) {
      scoring();
      checkWin();
    }
  }  
}

void display() {
  drawCenterLine();  
  playerPaddle.display();
  enemyPaddle.display(); 
  pong.display();
  score.display();
  if (debug == 1) debug();
  copyrightText();
  youWin();
}

void displayMainMenu() {
  textAlign(CENTER);
  textSize(110);
  text("Pong", width/2, height/2-50);
  textSize(25);
  //textFont();
  text("by @putuprema.dn", width/2, height/2-10);
  textSize(35);
  text("Press spacebar to start", width/2, height/2+150);
}

void checkWin() {
  if (score.enemy >= 10) {
    enemyWin = true;
    println("Enemy wins");
  } else if (score.player >= 10) {
    playerWin = true;
    println("Player wins");
  } else {
    if (playerDead) {
      pong = new Ball(width/2+10,height-10,5,-5);
      playerDead = false;
    } else if (enemyDead) {
      pong = new Ball(width/2-10,height-10,-5,-5);
      enemyDead = false;
    }
  }
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
  else if ((enemyWin || playerWin || firstRun) && key == 32) reset();
}

void reset() {
  score.enemy=score.player=0;
  enemyDead=playerDead=enemyWin=playerWin=false;
  if (!firstRun) firstRun = true;
  else {
    firstRun = false;
    pong = new Ball(width/2-10,height-10,-5,-5);
  }
}

void debug() {
  textAlign(LEFT);
  textSize(25);
  text("Bounce angle:", 10, height-70);
  text(pong.bounceAngle*57.295779513, 170, height-70);
  text("Pong hit position:", 10, height-50);
  text(pong.collisionPos, 170, height-50);
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

void copyrightText() {
  textAlign(RIGHT);
  textSize(25);
  text("Created by @putuprema.dn", width-10, height-10);
}

void youWin() {
  if (enemyWin) {
    textAlign(LEFT);
    textSize(95);
    text("AI WINS",width/2+30,height/2-30);
    textSize(30);
    text("Press spacebar", width/2+30, height/2+10);
    text("to reset", width/2+30, height/2+50);
  } else if (playerWin) {
    textAlign(RIGHT);
    textSize(95);
    text("YOU WIN",width/2-30,height/2-30);
    textSize(30);
    text("Press spacebar", width/2-30, height/2+10);
    text("to reset", width/2-30, height/2+50);   
  }
}
