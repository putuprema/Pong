class Score {
  int enemy;
  int player;
  
  Score() {
    
  }
  
  // Display the scores on screen
  void display() {
    fill(255);
    textSize(60);
    textAlign(LEFT);
    text(enemy, width/2+20, 70);
    textAlign(RIGHT);
    text(player, width/2-20, 70);  
  }
}
