class Ghost {
  int xGrid;
  int yGrid;
  float xVel;
  float yVel;
  boolean vulnerable;
  boolean allowMove;
  String currentDirection;

  //initializing ghosts with given positions (as called in main) and no movement
  Ghost(int x, int y) {
    xGrid = x;
    yGrid = y;
    xVel = 0;
    yVel = 0;
    vulnerable = false;
  }

  //drawing the ghosts by loading different images based on the directions they are going in
  void drawGhost(int i) {
    //if scared
    if (vulnerable) {
      if (frameCount%16 < 4) {
        image(scaredGhost1, xGrid*GRID_SIZE, yGrid*GRID_SIZE, 40, 40);
      } else if (frameCount%16 >= 4 && frameCount%16 < 8) {
        image(scaredGhost2, xGrid*GRID_SIZE, yGrid*GRID_SIZE, 40, 40);
      } else if (frameCount%16 >= 8 && frameCount%16 < 12) {
        image(scaredGhost3, xGrid*GRID_SIZE, yGrid*GRID_SIZE, 40, 40);
      } else if (frameCount%16 >= 12) {
        image(scaredGhost4, xGrid*GRID_SIZE, yGrid*GRID_SIZE, 40, 40);
      }
    } else {
      if (i%4 == 0) {
        if (xVel > 0) {
          image(ghostR, xGrid*GRID_SIZE, yGrid*GRID_SIZE, 40, 40);
        } else if (xVel < 0) {
          image(ghostL, xGrid*GRID_SIZE, yGrid*GRID_SIZE, 40, 40);
        } else if (yVel > 0) {
          image(ghostD, xGrid*GRID_SIZE, yGrid*GRID_SIZE, 40, 40);
        } else if (yVel < 0) {
          image(ghostU, xGrid*GRID_SIZE, yGrid*GRID_SIZE, 40, 40);
        } else {
          image(ghostR, xGrid*GRID_SIZE, yGrid*GRID_SIZE, 40, 40);
        }
      } else if (i%4 == 1) {
        if (xVel > 0) {
          image(ghost1R, xGrid*GRID_SIZE, yGrid*GRID_SIZE, 40, 40);
        } else if (xVel < 0) {
          image(ghost1L, xGrid*GRID_SIZE, yGrid*GRID_SIZE, 40, 40);
        } else if (yVel > 0) {
          image(ghost1D, xGrid*GRID_SIZE, yGrid*GRID_SIZE, 40, 40);
        } else if (yVel < 0) {
          image(ghost1U, xGrid*GRID_SIZE, yGrid*GRID_SIZE, 40, 40);
        } else {
          image(ghost1R, xGrid*GRID_SIZE, yGrid*GRID_SIZE, 40, 40);
        }
      } else if (i%4 == 2) {
        if (xVel > 0) {
          image(ghost2R, xGrid*GRID_SIZE, yGrid*GRID_SIZE, 40, 40);
        } else if (xVel < 0) {
          image(ghost2L, xGrid*GRID_SIZE, yGrid*GRID_SIZE, 40, 40);
        } else if (yVel > 0) {
          image(ghost2D, xGrid*GRID_SIZE, yGrid*GRID_SIZE, 40, 40);
        } else if (yVel < 0) {
          image(ghost2U, xGrid*GRID_SIZE, yGrid*GRID_SIZE, 40, 40);
        } else {
          image(ghost2R, xGrid*GRID_SIZE, yGrid*GRID_SIZE, 40, 40);
        }
      } else if (i%4 == 3) {
        if (xVel > 0) {
          image(ghost3R, xGrid*GRID_SIZE, yGrid*GRID_SIZE, 40, 40);
        } else if (xVel < 0) {
          image(ghost3L, xGrid*GRID_SIZE, yGrid*GRID_SIZE, 40, 40);
        } else if (yVel > 0) {
          image(ghost3D, xGrid*GRID_SIZE, yGrid*GRID_SIZE, 40, 40);
        } else if (yVel < 0) {
          image(ghost3U, xGrid*GRID_SIZE, yGrid*GRID_SIZE, 40, 40);
        } else {
          image(ghost3R, xGrid*GRID_SIZE, yGrid*GRID_SIZE, 40, 40);
        }
      }
    }
  }

  //ghosts stop when they hit a wall
  void ghostMoves() {
    //checks if wall is ahead
    if (currentDirection == "up" && yGrid-1 >= -1 && BLUEPRINT[yGrid-1][xGrid] != 'W') {
      allowMove = true;
    } else if ( currentDirection == "down" && yGrid+1 < CELLS_PER_ROW && BLUEPRINT[yGrid+1][xGrid] != 'W') {
      allowMove = true;
    } else if (currentDirection == "left" && xGrid-1 >= 0 && BLUEPRINT[yGrid][xGrid-1] != 'W') {
      allowMove = true;
    } else if (currentDirection == "right" && xGrid+1 < CELLS_PER_ROW && BLUEPRINT[yGrid][xGrid+1] != 'W') {
      allowMove = true;
    }
    //if wall ahead, stop
    if (!allowMove) {
      currentDirection = "none";
    }
    //changing directions
    switch(currentDirection) {
    case "up":
      xVel = 0;
      yVel = -1;
      break;
    case "down":
      xVel = 0;
      yVel = 1;
      break;
    case "left":
      yVel = 0;
      xVel = -1;
      break;
    case "right":
      yVel = 0;
      xVel = 1;
      break;
    case "none":
      xVel = 0;
      yVel = 0;
    }
    //actually moving
    xGrid += xVel;
    yGrid += yVel;
    allowMove = false;
  }

  //change the direction of the ghosts at random
  void ghostChangeDirection() {
    float direction = random(4);
    switch((int)direction) {
    case 0:
      currentDirection = "up";
      break;
    case 1:
      currentDirection = "down";
      break;
    case 2:
      currentDirection = "left";
      break;
    case 3:
      currentDirection = "right";
      break;
    }
  }

  //overloaded function allows me to hard code directions (useful for helping ghosts escape their "cage")
  void ghostChangeDirection(String direction) {
    switch(direction) {
    case "up":
      currentDirection = "up";
      break;
    case "down":
      currentDirection = "down";
      break;
    case "left":
      currentDirection = "left";
      break;
    case "right":
      currentDirection = "right";
      break;
    }
  }
}
