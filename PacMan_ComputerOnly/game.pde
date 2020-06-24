//-----------------------------------------------------------------------------------------------------------
// preGame() FUNCTION
//-----------------------------------------------------------------------------------------------------------

void preGame() { //starting screen
  background(0);

  //title
  fill(253, 255, 0);
  textFont(crackman);
  textAlign(CENTER, CENTER);
  textSize(100);
  text("PAC-MAN", 400, 300);

  //instructions
  fill(219, 133, 28);
  textFont(pressStart);
  textSize(13);
  if (frameCount%16 < 8) {
    text("Use L/R arrow keys to select difficulty", 400, 400);
    text("Press SPACE to start", 400, 440);
  }

  fill(255);
  textSize(30);

  //game level displays (with different colours), changed based on L/R key input
  if (gameLevel == 0) {
    fill(70, 191, 238);
  } else {
    fill(255);
  }
  text("EASY", 200, 500);
  if (gameLevel == 1) {
    fill(208, 62, 25);
  } else {
    fill(255);
  }
  text("MEDIUM", 400, 500);
  if (gameLevel == 2) {
    fill(234, 130, 229);
  } else {
    fill(255);
  }
  text("HARD", 600, 500);
  if (gameLevel == 3) {
    fill(33, 33, 222);
  } else {
    fill(255);
  }
  text("EXPERT", 230, 580);
  if (gameLevel == 4) {
    fill(0, 255, 0);
  } else {
    fill(255);
  }
  text("IMPOSSIBLE", 510, 580);
}

//-----------------------------------------------------------------------------------------------------------
// gameLoop() FUNCTION
//-----------------------------------------------------------------------------------------------------------

void gameLoop() {
  //background wiped every iteration of draw() so no duplicate images
  background(0); 

  //adding or removing ghosts based on level chosen
  if (gameLevel == 0 && ghosts.size() > 2) {
    ghosts.remove(2);
  }

  if (gameLevel == 2 && ghosts.size() < 5) {
    ghosts.add(new Ghost(9, 9));
    ghosts.add(new Ghost(9, 10));
  }

  if (gameLevel == 3 && ghosts.size() < 5) {
    ghosts.add(new Ghost(9, 8));
    ghosts.add(new Ghost(9, 9));
    ghosts.add(new Ghost(10, 9));
    ghosts.add(new Ghost(10, 8));
  }

  if (gameLevel == 4 && ghosts.size() < 5) {
    ghosts.add(new Ghost(9, 8));
    ghosts.add(new Ghost(9, 9));
    ghosts.add(new Ghost(10, 9));
    ghosts.add(new Ghost(10, 8));
    ghosts.add(new Ghost(1, 1));
    ghosts.add(new Ghost(8, 1));
    ghosts.add(new Ghost(11, 1));
    ghosts.add(new Ghost(18, 1));
    ghosts.add(new Ghost(5, 5));
    ghosts.add(new Ghost(14, 5));
    ghosts.add(new Ghost(3, 10));
    ghosts.add(new Ghost(15, 10));
    ghosts.add(new Ghost(1, 18));
    ghosts.add(new Ghost(7, 18));
    ghosts.add(new Ghost(12, 18));
    ghosts.add(new Ghost(18, 18));
  }

  //hub at the bottom displays lives and score
  fill(255);
  textAlign(LEFT);
  textSize(25);
  text("SCORE: " + SCORE, 400, 840);

  //draws number of lives left in pacmans
  for (int i = 0; i < LIVES; i++) {
    image(pacman11, 20 + 40*i, 805, 30, 30);
  }

  //draws the walls
  for (int i = 0; i < walls.size(); i++) {
    walls.get(i).drawWall();
  }

  //if powerups are eaten make ghosts vulnerable
  for (int i = 0; i < powerup.size(); i++) {
    if (powerup.get(i).checkEaten(i)) {
      freezeFrame = makeGhostsVulnerable();
    }
    powerup.get(i).drawPowerup();
  }

  //after certain amount of time ghosts are not vulnerable anymore
  makeGhostsNotVulnerable(freezeFrame);

  //drawing food if food has not been eaten
  for (int i = 0; i < food.size(); i++) { 
    food.get(i).checkEaten(i);
    food.get(i).drawFood();
  }

  //drawing and moving pacman, changing direction based on inputs from arduino switches
  pacman.drawPacman(); 
  pacman.pacmanMoves();

  //drawing and moving ghosts
  for (int i = 0; i < ghosts.size(); i++) { 
    ghosts.get(i).drawGhost(i);
    ghosts.get(i).ghostMoves();
  }

  //ghosts change direction 5% of the time or if they have stopped
  for (int i = 0; i < ghosts.size(); i++) { 
    if (ghosts.get(i).currentDirection == "none" || random(1) < 0.05) {
      ghosts.get(i).ghostChangeDirection();
    }
    //helps ghosts "escape" the center "cage" where they spawn
    if ((ghosts.get(i).xGrid == 9 || ghosts.get(i).xGrid == 10) && ghosts.get(i).yGrid == 10) {
      ghosts.get(i).ghostChangeDirection("up");
    }
  }

  scoring(); //updates score

  //checks for collision, instantiates new pacman if yes
  if (checkCollision() == 1 && (pacman.xGrid != 10 || pacman.yGrid != 12)) { 
    pacman = new Pacman(10, 12);
    LIVES--;
  }

  //checking lose condition (all lives gone) and loading end screen if true
  if (LIVES <= 0) {
    final int endScore = SCORE;
    gameOver = true;
    background(0);

    //outline
    stroke(0, 0, 255);
    noFill();
    strokeWeight(5);
    rect(120, 200, 570, 480);

    //text
    fill(253, 255, 0);
    textFont(crackman);
    textAlign(CENTER, CENTER);
    textSize(100);
    text("YOU LOST", 400, 300);

    textFont(pressStart);
    textSize(40);
    fill(219, 133, 28);
    text("BETTER LUCK\n NEXT TIME!", 400, 430);

    fill(255);
    textSize(20);
    text("SCORE: " + endScore, 400, 530);
    LIVES = 0;

    //restart by pressing the space bar
    textSize(13);
    text("Press SPACE to restart", 400, 600);
  }

  //checking win condition (all food eaten and lives > 0) and loading end screen if true
  if (checkWin()) {
    gameOver = true;
    background(0);

    //outline
    stroke(0, 0, 255);
    noFill();
    strokeWeight(5);
    rect(20, 200, 760, 400);

    //text
    fill(253, 255, 0);
    textFont(crackman);
    textAlign(CENTER, CENTER);
    textSize(70);
    text("CONGRATULATIONS!", 400, 300);

    fill(219, 133, 28);
    textFont(pressStart);
    textSize(40);
    text("YOU DEFEATED\nTHE GHOSTS", 400, 430);

    //restart by pressing the space bar
    fill(255);
    textSize(13);
    text("Press SPACE to restart", 400, 520);
  }
}

//-----------------------------------------------------------------------------------------------------------
// gameOver() FUNCTION
//-----------------------------------------------------------------------------------------------------------

void gameOver() {
  //reset everything to original values
  gameHasStarted = false;
  gameOver = false;
  LIVES = 4;
  SCORE = 0;
  gameLevel = 0;

  //food and powerups reset
  for (int i = 0; i < food.size(); i++) {
    food.get(i).eaten = false;
  }
  for (int i = 0; i < powerup.size(); i++) {
    powerup.get(i).eaten = false;
  }

  // to respawn ghosts at center and reset levels, all ghosts are removed and respawned
  while (ghosts.size() > 0) {
    ghosts.remove(0);
  }
  for (int i = 0; i < BLUEPRINT.length; i++) {
    for (int j = 0; j < BLUEPRINT[i].length; j++) {
      if (BLUEPRINT[i][j] == 'G') {
        ghosts.add(new Ghost(j, i));
      }
    }
  }
}
