class Ghost {
  //initializing ghosts with given positions (as called in main) and no movement
  constructor(x, y) {
    this.xGrid = x;
    this.yGrid = y;
    this.xVel = 0;
    this.yVel = 0;
    this.vulnerable = false;
    this.allowMove = false;
    this.currentDirection = "none";
  }

  //drawing the ghosts by loading different images based on the directions they are going in
  drawGhost(i) {
    //if scared
    if (this.vulnerable) {
      if (frameCount%16 < 4) {
        image(scaredGhost1, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 40, 40);
      } else if (frameCount%16 >= 4 && frameCount%16 < 8) {
        image(scaredGhost2, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 40, 40);
      } else if (frameCount%16 >= 8 && frameCount%16 < 12) {
        image(scaredGhost3, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 40, 40);
      } else if (frameCount%16 >= 12) {
        image(scaredGhost4, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 40, 40);
      }
    } else {
      if (i%4 == 0) {
        if (this.xVel > 0) {
          image(ghostR, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 40, 40);
        } else if (this.xVel < 0) {
          image(ghostL, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 40, 40);
        } else if (this.yVel > 0) {
          image(ghostD, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 40, 40);
        } else if (this.yVel < 0) {
          image(ghostU, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 40, 40);
        } else {
          image(ghostR, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 40, 40);
        }
      } else if (i%4 == 1) {
        if (this.xVel > 0) {
          image(ghost1R, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 40, 40);
        } else if (this.xVel < 0) {
          image(ghost1L, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 40, 40);
        } else if (this.yVel > 0) {
          image(ghost1D, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 40, 40);
        } else if (this.yVel < 0) {
          image(ghost1U, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 40, 40);
        } else {
          image(ghost1R, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 40, 40);
        }
      } else if (i%4 == 2) {
        if (this.xVel > 0) {
          image(ghost2R, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 40, 40);
        } else if (this.xVel < 0) {
          image(ghost2L, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 40, 40);
        } else if (this.yVel > 0) {
          image(ghost2D, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 40, 40);
        } else if (this.yVel < 0) {
          image(ghost2U, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 40, 40);
        } else {
          image(ghost2R, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 40, 40);
        }
      } else if (i%4 == 3) {
        if (this.xVel > 0) {
          image(ghost3R, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 40, 40);
        } else if (this.xVel < 0) {
          image(ghost3L, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 40, 40);
        } else if (this.yVel > 0) {
          image(ghost3D, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 40, 40);
        } else if (this.yVel < 0) {
          image(ghost3U, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 40, 40);
        } else {
          image(ghost3R, this.xGrid*GRID_SIZE, this.yGrid*GRID_SIZE, 40, 40);
        }
      }
    }
  }

  //ghosts stop when they hit a wall
  ghostMoves() {
    //checks if wall is ahead
    if (this.currentDirection == "up" && this.yGrid-1 >= -1 && BLUEPRINT[this.yGrid-1][this.xGrid] != 'W') {
      this.allowMove = true;
    } else if ( this.currentDirection == "down" && this.yGrid+1 < CELLS_PER_ROW && BLUEPRINT[this.yGrid+1][this.xGrid] != 'W') {
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
    //actually moving
    this.xGrid += this.xVel;
    this.yGrid += this.yVel;
    this.allowMove = false;
  }

  //change the direction of the ghosts at random
  ghostChangeDirection() {
    let direction = random(4);
    switch(int(direction)) {
    case 0:
      this.currentDirection = "up";
      break;
    case 1:
      this.currentDirection = "down";
      break;
    case 2:
      this.currentDirection = "left";
      break;
    case 3:
      this.currentDirection = "right";
      break;
    }
  }

  //overloaded function allows me to hard code directions (useful for helping ghosts escape their "cage")
  ghostGoUp(direction) {
    this.currentDirection = "up";
  }
}