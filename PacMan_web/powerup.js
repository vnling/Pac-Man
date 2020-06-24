class Powerup {
  constructor(x, y) {
    this.xGrid = x;
    this.yGrid = y;
    this.eaten = false;
  }

  drawPowerup() {
    if (!this.eaten) {
      fill(255);
      stroke(255);
      circle(this.xGrid*GRID_SIZE + 20, this.yGrid*GRID_SIZE + 20, 20);
    }
  }
  
  //returns true if eaten 
  checkEaten(i) {
    if (pacman.xGrid == powerup[i].xGrid && pacman.yGrid == powerup[i].yGrid && !powerup[i].eaten) 
    {
      powerup[i].eaten = true;
      return true;
    }
    return false;
  }
}