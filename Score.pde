class Score {
  int enemy;
  int player;
  
  Score() {
    
  }
  
  void display() {
    fill(255);
    textSize(60);
    textAlign(LEFT);
    text(enemy, width/2+20, 70);
    textAlign(RIGHT);
    text(player, width/2-20, 70);  
  }
}
