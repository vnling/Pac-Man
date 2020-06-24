//creating constants to represent grid size and the number of cells per row (for the food pellets, one pellet per cell)
const GRID_SIZE = 40;
const CELLS_PER_ROW = 20;

//initializing image objects
let fruit1;
let fruit2;
let fruit3;
let fruit4;
let fruit5;
let fruit6;
let ghostR;
let ghostL;
let ghostD;
let ghostU;
let ghost1R;
let ghost1L;
let ghost1D;
let ghost1U;
let ghost2R;
let ghost2L;
let ghost2D;
let ghost2U;
let ghost3R;
let ghost3L;
let ghost3D;
let ghost3U;
let scaredGhost1;
let scaredGhost2;
let scaredGhost3;
let scaredGhost4;
let pacman1;
let pacman2;
let pacman3;
let pacman4;
let pacman5;
let pacman6;
let pacman7;
let pacman8;
let pacman9;
let pacman10;
let pacman11;
let pacman12;

//initializing fonts
let crackman, pressStart;

//setting game state and markers as global variables
let LIVES = 4;
let SCORE = 0;
let freezeFrame; //used to make ghosts scared
let gameLevel = 0;
let gameHasStarted = false;
let gameIsOver = false;

//initializing the pacman, ghost, and food instances
//pacman is created near the center
let pacman;
let levels = [0, 1, 2, 3, 4];
let ghosts = [];
let powerup = [];
let food = [];
var walls = [];

function preload() {
  //loading images
  fruit1 = loadImage("./libraries/fruit1.png");
  fruit2 = loadImage("./libraries/fruit2.png");
  fruit3 = loadImage("./libraries/fruit3.png");
  fruit4 = loadImage("./libraries/fruit4.png");
  fruit5 = loadImage("./libraries/fruit5.png");
  fruit6 = loadImage("./libraries/fruit6.png");
  ghostR = loadImage("./libraries/ghostR.png");
  ghostL = loadImage("./libraries/ghostL.png");
  ghostD = loadImage("./libraries/ghostD.png");
  ghostU = loadImage("./libraries/ghostU.png");
  ghost1R = loadImage("./libraries/ghost1R.png");
  ghost1L = loadImage("./libraries/ghost1L.png");
  ghost1D = loadImage("./libraries/ghost1D.png");
  ghost1U = loadImage("./libraries/ghost1U.png");
  ghost2R = loadImage("./libraries/ghost2R.png");
  ghost2L = loadImage("./libraries/ghost2L.png");
  ghost2D = loadImage("./libraries/ghost2D.png");
  ghost2U = loadImage("./libraries/ghost2U.png");
  ghost3R = loadImage("./libraries/ghost3R.png");
  ghost3L = loadImage("./libraries/ghost3L.png");
  ghost3D = loadImage("./libraries/ghost3D.png");
  ghost3U = loadImage("./libraries/ghost3U.png");
  scaredGhost1 = loadImage("./libraries/scaredghost1.png");
  scaredGhost2 = loadImage("./libraries/scaredghost2.png");
  scaredGhost3 = loadImage("./libraries/scaredghost3.png");
  scaredGhost4 = loadImage("./libraries/scaredghost4.png");
  pacman1 = loadImage("./libraries/pacman1.png");
  pacman2 = loadImage("./libraries/pacman2.png");
  pacman3 = loadImage("./libraries/pacman3.png");
  pacman4 = loadImage("./libraries/pacman4.png");
  pacman5 = loadImage("./libraries/pacman5.png");
  pacman6 = loadImage("./libraries/pacman6.png");
  pacman7 = loadImage("./libraries/pacman7.png");
  pacman8 = loadImage("./libraries/pacman8.png");
  pacman9 = loadImage("./libraries/pacman9.png");
  pacman10 = loadImage("./libraries/pacman10.png");
  pacman11 = loadImage("./libraries/pacman11.png");
  pacman12 = loadImage("./libraries/pacman12.png");

  //loading fonts
  crackman = loadFont("./libraries/crackman.regular.ttf");
  pressStart = loadFont("./libraries/PressStart2P.ttf");
}

function setup() {
  createCanvas(800, 850);
  frameRate(8);

  textFont(pressStart);
  
  pacman = new Pacman(10, 12);
  
  //constructing board and elements
  for (i = 0; i < BLUEPRINT.length; i++) {
    for (j = 0; j < BLUEPRINT[i].length; j++) {
      if (BLUEPRINT[i][j] === 'W') {
        walls.push(new Wall(j, i));
      } else if (BLUEPRINT[i][j] === ' ') {
        food.push(new Food(j, i));
      } else if (BLUEPRINT[i][j] === 'P') {
        powerup.push(new Powerup(j, i));
      } else if (BLUEPRINT[i][j] === 'G') {
        ghosts.push(new Ghost(j, i));
      }
    }
  }  
}

function draw() {
  if (!gameHasStarted) {
    preGame(); //show starting screen if game has not started
  } else if (!gameIsOver) {
    gameLoop(); //show game if game is not over
  }
}

//-----------------------------------------------------
//function definitions begin here

//updates score based on number of food items eaten
function scoring() {
  let counter = 0;
  for (var i = 0; i < food.length; i++) {
      if (food[i].eaten && !food[i].isFruit) {
        counter += 100;
      } else if (food[i].eaten) { //fruits are worth more
        counter += 400;
      }
  }
  SCORE = counter;
}

//checks if all food has been eaten
function checkWin() {
  let allEaten = true;
  for (var i = 0; i < food.length; i++) {
      if (!food[i].eaten) {
        allEaten = false;
      }
  }
  return allEaten;
}

//checks if Pac-Man has collided with a ghost
//returns 0 for no collision, 1 for pacman eaten by ghost, 2 for ghost eaten by pacman
function checkCollision() {
  let collided = 0;
  for (var i = 0; i < ghosts.length; i++) {
    if (pacman.xGrid === ghosts[i].xGrid && pacman.yGrid === ghosts[i].yGrid && ghosts[i].vulnerable === false) {
      collided = 1;
    } else if (pacman.xGrid === ghosts[i].xGrid && pacman.yGrid === ghosts[i].yGrid && ghosts[i].vulnerable === true) {
      // ghosts.push(new Ghost(int(random(8,12)), 10)); //ghost "dies" and respawns
      // delete ghosts[i]; 
      ghosts.splice(i, 1);
      ghosts.push(new Ghost(int(random(8,12)), 10)); //ghost "dies" and respawns
      SCORE += 400;
      collided = 2; //not strictly necessary but for return value
    }
  }
  return collided; 
}

//makes ghosts vulnerable to pacman
function makeGhostsVulnerable() {
  for (var i = 0; i < ghosts.length; i++) {
    ghosts[i].vulnerable = true;
  }
  return frameCount;
}

//makes ghosts invulnerable again
function makeGhostsNotVulnerable(freezeFrame) {
  if (frameCount - freezeFrame > 40) { //make vulnerable for 5 seconds
    for (var i = 0; i < ghosts.length; i++) {
      ghosts[i].vulnerable = false;
    }
  }
}

//allows the user to change Pac-Man's direction using arrow keys 
function keyPressed() {
  //if game hasn't started, arrow keys change levels
  if (!gameHasStarted) {
    if (keyCode === RIGHT_ARROW && gameLevel != 4) {
      gameLevel++;
    } else if (keyCode === LEFT_ARROW && gameLevel != 0) {
      gameLevel--;
    } else if (keyCode === ENTER) {
      gameHasStarted = true;
    }
  }
  //if game has started, arrow keys change pacman's direction
  else if (gameHasStarted && !gameIsOver) {
    if (keyCode === UP_ARROW) {
      pacman.pacmanChangeDirection("up");
    } else if (keyCode === RIGHT_ARROW) {
      pacman.pacmanChangeDirection("right");
    } else if (keyCode === LEFT_ARROW) {
      pacman.pacmanChangeDirection("left");
    } else if (keyCode === DOWN_ARROW) {
      pacman.pacmanChangeDirection("down");
    }
  }
  //if space bar pressed when game is over, run gameOver() (in game.pde)
  else if (gameIsOver) {
    if (keyCode === ENTER) {
      gameOver();
    }
  }
}