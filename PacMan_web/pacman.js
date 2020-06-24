class Pacman {
  //pacman initialized with given position and no movement
  constructor(x, y) {
    this.xGrid = x;
    this.yGrid = y;
    this.xVel = 0;
    this.yVel = 0;
    this.allowMove = false;
    this.currentDirection = "none";
  }

  //drawing pacman, outer if condition determines the direction pacman is going in
  //inner if condition allows for animation based on the framecount
  drawPacman() {
    if (this.xVel > 0) {
      if (frameCount%6 < 2) {
        image(pacman1, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 35, 35);
      } else if (frameCount%6 >= 2 && frameCount%6 < 4) {
        image(pacman2, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 35, 35);
      } else if (frameCount%6 >= 4) {
        image(pacman3, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 35, 35);
      }
} else if (this.xVel < 0) {
      if (frameCount%6 < 2) {
        image(pacman7, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 35, 35);
      } else if (frameCount%6 >= 2 && frameCount%6 < 4) {
        image(pacman8, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 35, 35);
      } else if (frameCount%6 >= 4) {
        image(pacman9, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 35, 35);
      }
    } else if (this.yVel > 0) {
      if (frameCount%6 < 2) {
        image(pacman4, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 35, 35);
      } else if (frameCount%6 >= 2 && frameCount%6 < 4) {
        image(pacman5, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 35, 35);
      } else if (frameCount%6 >= 4) {
        image(pacman6, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 35, 35);
      }
    } else if (this.yVel < 0) {
      if (frameCount%6 < 2) {
        image(pacman10, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 35, 35);
      } else if (frameCount%6 >= 2 && frameCount%6 < 4) {
        image(pacman11, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 35, 35);
      } else if (frameCount%6 >= 4) {
        image(pacman12, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 35, 35);
      }
    } else {
      if (frameCount%6 < 2) {
        image(pacman1, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 35, 35);
      } else if (frameCount%6 >= 2 && frameCount%6 < 4) {
        image(pacman2, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 35, 35);
      } else if (frameCount%6 >= 4) {
        image(pacman3, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 35, 35);
      }
    }
  }

  pacmanMoves() {
    //allows pacman to move through portal
    if (this.xGrid == 0 && this.yGrid == 10 && this.currentDirection == "left") {
      this.xGrid = 20;
    } else if (this.xGrid == 19 && this.yGrid == 10 && this.currentDirection == "right") {
      this.xGrid = 0;
    }
    //checks if wall is ahead
    if (this.currentDirection == "up" && this.yGrid-1 >= -1 && BLUEPRINT[this.yGrid-1][this.xGrid] != 'W') {
      this.allowMove = true;
    } else if (this.currentDirection == "down" && this.yGrid+1 < CELLS_PER_ROW && BLUEPRINT[this.yGrid+1][this.xGrid] != 'W') {
      this.allowMove = true;
    } else if (this.currentDirection == "left" && this.xGrid-1 >= 0 && BLUEPRINT[this.yGrid][this.xGrid-1] != 'W') {
      this.allowMove = true;
    } else if (this.currentDirection == "right" && this.xGrid+1 < CELLS_PER_ROW && BLUEPRINT[this.yGrid][this.xGrid+1] != 'W') {
      this.allowMove = true;
    }
    //if wall ahead, stop
    if (!this.allowMove) {
      this.currentDirection = "none";
    }
    //changing directions
    switch(this.currentDirection) {
    case "up":
      this.xVel = 0;
      this.yVel = -1;
      break;
    case "down":
      this.xVel = 0;
      this.yVel = 1;
      break;
    case "left":
      this.yVel = 0;
      this.xVel = -1;
      break;
    case "right":
      this.yVel = 0;
      this.xVel = 1;
      break;
    case "none":
      this.xVel = 0;
      this.yVel = 0;
    }
    //actual movement
    this.xGrid += this.xVel;
    this.yGrid += this.yVel;
    this.allowMove = false;
  }

  //pacman changes direction based on key input (from keyPressed())
  pacmanChangeDirection(direction) {
    switch(direction) {
    case "up":
      this.currentDirection = "up";
      break;
    case "down":
      this.currentDirection = "down";
      break;
    case "left":
      this.currentDirection = "left";
      break;
    case "right":
      this.currentDirection = "right";
      break;
    }
  }
}