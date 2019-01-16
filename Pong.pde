// Declare all game objects
Paddle playerPaddle;
Paddle enemyPaddle;
Ball pong;
Score score;
PFont bebas;

boolean playerDead, enemyDead, playerWin, enemyWin, firstRun=true; // Some flag to determine who's dead, who wins, and first run status.
int debug=-1; // Show debug info such as ball position, speed, etc (default disabled)

void setup() {
  size(640,480,P2D); // Window size
  frameRate(60); // Set framerate to 60fps
  playerPaddle = new Paddle(30,height/2); // Create new paddle object for Player
  enemyPaddle = new Paddle(width-45, height/2-100); // Create new paddle object for Enemy
  pong = new Ball(width/2-10,height-10,-5,-5); // Create the pong object
  score = new Score(); // Score object to store..well..scores.
  bebas = createFont("fonts/BebasNeue.ttf",300,false); // Default font used in the game
}

void draw() {
  background(0); // Set background color to BLACK.
  textFont(bebas); // Set the game font to BebasNeue.
  if (firstRun) { // If first run then display the main menu.
    displayMainMenu();
  } else {
    display();
    update();
  }
}

void update() {
  playerPaddle.checkBoundary(); // Call checkBoundary function of Paddle object
  if (keyPressed) {
    //println(key);
    playerPaddle.move(); // Call move function of Paddle object
  }

  //enemyPaddle.pos.y = mouseY; // Move the paddle with mouse? (for debugging purposes)
  
  // Enemy paddle AI routine
  enemyPaddle.checkBoundary();
  if (!playerWin && !enemyWin) enemyPaddle.moveAI();
  //playerPaddle.moveAI(); // AI Player Mode
  
  //pong.pos.x = mouseX; // Move the pong with mouse? (for debugging purposes)
  //pong.pos.y = mouseY; // Move the pong with mouse? (for debugging purposes)
  
  if (pong.pos.x > width/2) pong.checkCollisionEnemy(); // If the ball is on the enemy side, check for enemy's paddle collision with the ball
  else pong.checkCollisionPlayer(); // else check for player's paddle collision with the ball
  pong.move(); // Move the ball
  
  // Do scoring and win checks if player/enemy is Dead.
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
  // Display all game objects
  drawCenterLine();  
  playerPaddle.display();
  enemyPaddle.display(); 
  pong.display();
  score.display();
  if (debug == 1) debug();
  copyrightText();
  youWin();
}

void displayMainMenu() { // Display main menu on first run.
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
    enemyWin = true; // If enemy's score >= 10 then enemy wins.
    println("Enemy wins");
  } else if (score.player >= 10) {
    playerWin = true; // else then player wins.
    println("Player wins");
  } else {
    // If no one has won yet but player/enemy is dead, create new ball object.
    if (playerDead) { 
      pong = new Ball(width/2+10,height-10,5,-5); // If player is dead, create the ball with initial direction going towards the enemy paddle
      playerDead = false;
    } else if (enemyDead) {
      pong = new Ball(width/2-10,height-10,-5,-5); // If enemy is dead, create the ball with initial direction going towards the player paddle
      enemyDead = false;
    }
  }
}

void scoring() {
  // Self-explanatory I guess...
  if (playerDead && !enemyDead) {
    score.enemy++;
    println("enemy score: ",score.enemy); // Just some debug stuff (not important)
  }
  else if (!playerDead && enemyDead) {
    score.player++;
    println("player score: ",score.player); // Just some debug stuff (not important)
  }
}

void keyReleased() {
  //println("key ", key, "released");
  key = 0; // After key is released, clear the value of 'key' variable.
}

void keyPressed() {
  //println("key ", key, "pressed");
  if (key == 'l') debug *= -1; // Press 'l' to show debug info such as ball position, speed, etc.
  else if ((enemyWin || playerWin || firstRun) && key == 32) reset(); // If first run/player wins/enemy wins, press SPACEBAR to start/restart the game.
}

void reset() {
  // Initialize all variables to 0 on reset/first run.
  score.enemy=score.player=0;
  enemyDead=playerDead=enemyWin=playerWin=false;
  if (!firstRun) firstRun = true;
  else {
    firstRun = false;
    pong = new Ball(width/2-10,height-10,-5,-5); // Create new ball object on reset/first run.
  }
}

void debug() {
  // Just some debug info (not important, press 'l' to show them on screen).
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

void drawCenterLine() { // Draw center line on screen
  stroke(255);
  strokeWeight(3);
  line(width/2,0,width/2,height);
  strokeWeight(1);  
}

void copyrightText() { // Display copyright info because I can
  textAlign(RIGHT);
  textSize(25);
  text("Created by @putuprema.dn", width-10, height-10);
}

void youWin() { // Display You WIN text :)
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
