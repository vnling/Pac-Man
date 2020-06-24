class Powerup {
  int xGrid;
  int yGrid;
  boolean eaten;

  Powerup(int x, int y) {
    xGrid = x;
    yGrid = y;
  }

  void drawPowerup() {
    if (!eaten) {
      fill(255);
      stroke(255);
      circle(xGrid*GRID_SIZE + 20, yGrid*GRID_SIZE + 20, 20);
    }
  }
  
  //returns true if eaten 
  boolean checkEaten(int i) {
    if (pacman.xGrid == powerup.get(i).xGrid && pacman.yGrid == powerup.get(i).yGrid && !powerup.get(i).eaten) 
    {
      powerup.get(i).eaten = true;
      return true;
    }
    return false;
  }
}
