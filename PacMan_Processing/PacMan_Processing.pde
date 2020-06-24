/*
  Concept: My version of the famous arcade game Pac-Man. The player's aim is to eat all the food pellets
 while avoiding the ghosts. The player starts the game with four lives. Each collision with a ghost reduces the 
 player's lives by one, and the Pac-Man sprite respawns near the center of the screen. Each food pellet consumed 
 gives the player a score increment of 100. Powerups, represented by large circles, make ghosts vulnerable to Pac-Man 
 for 5 seconds (and make Pac-Man invulnerable to the ghosts, allowing Pac-Man to "eat" the ghosts.) Each ghost "eaten" by 
 Pac-Man gives a score increment of 400, and each special fruit pellet (represented by fruit images) consumed gives 
 a score increment of 400 as well. Pac-Man and the ghosts cannot travel through "walls", represented by solid blue squares. 
 Pac-Man can, however, exit the screen on the left and return from the right.
 
 Instructions for use: The player can control Pac-Man's movement with the arrow keys on their computer. They should try to 
 avoid ghosts and eat the food pellets.
 
 Name: Vee Nis Ling
 Due Date: 24 June 2020
 */

//-----------------------------------------------------------------------------------------------------------
// IMPORTING LIBRARIES AND CREATING OBJECT VARIABLES
//-----------------------------------------------------------------------------------------------------------

//importing serial library to receive arduino input    
import processing.serial.*;

//importing minim to process sound file
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//setting up serial port
Serial myPort;
int switchInput = 0;
int potInput = 0;

//setting up minim
Minim minim;
AudioPlayer player;

//creating constants to represent grid size and the number of cells per row (for the food pellets, one pellet per cell)
final int GRID_SIZE = 40;
final int CELLS_PER_ROW = 20;

//initializing image objects
PImage fruit1;
PImage fruit2;
PImage fruit3;
PImage fruit4;
PImage fruit5;
PImage fruit6;
PImage ghostR;
PImage ghostL;
PImage ghostD;
PImage ghostU;
PImage ghost1R;
PImage ghost1L;
PImage ghost1D;
PImage ghost1U;
PImage ghost2R;
PImage ghost2L;
PImage ghost2D;
PImage ghost2U;
PImage ghost3R;
PImage ghost3L;
PImage ghost3D;
PImage ghost3U;
PImage scaredGhost1;
PImage scaredGhost2;
PImage scaredGhost3;
PImage scaredGhost4;
PImage pacman1;
PImage pacman2;
PImage pacman3;
PImage pacman4;
PImage pacman5;
PImage pacman6;
PImage pacman7;
PImage pacman8;
PImage pacman9;
PImage pacman10;
PImage pacman11;
PImage pacman12;

//initializing fonts
PFont crackman, pressStart;

//setting global variables
int LIVES = 4; //number of lives
int SCORE = 0; //player's score
int freezeFrame; //used as a reference to make ghosts vulnerable for 5 seconds
String gameLevel; //used to toggle game difficulty
boolean gameHasStarted = false; //state variables
boolean gameOver = false;

//initializing the pacman, ghost, and food instances
//pacman is created in the middle of the screen
Pacman pacman = new Pacman(10, 12);
ArrayList<Ghost> ghosts = new ArrayList<Ghost>();
ArrayList<Powerup> powerup = new ArrayList<Powerup>();
ArrayList<Food> food = new ArrayList<Food>();
ArrayList<Wall> walls = new ArrayList<Wall>();

//-----------------------------------------------------------------------------------------------------------
// setup() FUNCTION
//-----------------------------------------------------------------------------------------------------------

void setup() {
  size(800, 850);
  frameRate(8); //chosen for best experience

  //serial port setup
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');

  //playing music
  minim = new Minim(this);
  player = minim.loadFile("pacman.mp3");
  player.loop();

  //creating walls, food, powerups, and ghosts based on BLUEPRINT (in board.pde file)
  for (int i = 0; i < BLUEPRINT.length; i++) {
    for (int j = 0; j < BLUEPRINT[i].length; j++) {
      //wall
      if (BLUEPRINT[i][j] == 'W') {
        walls.add(new Wall(j, i));
      } else if (BLUEPRINT[i][j] == ' ') {
        food.add(new Food(j, i));
      } else if (BLUEPRINT[i][j] == 'P') {
        powerup.add(new Powerup(j, i));
      } else if (BLUEPRINT[i][j] == 'G') {
        ghosts.add(new Ghost(j, i));
      }
    }
  }

  //loading images
  fruit1 = loadImage("fruit1.png");
  fruit2 = loadImage("fruit2.png");
  fruit3 = loadImage("fruit3.png");
  fruit4 = loadImage("fruit4.png");
  fruit5 = loadImage("fruit5.png");
  fruit6 = loadImage("fruit6.png");
  ghostR = loadImage("ghostR.png");
  ghostL = loadImage("ghostL.png");
  ghostD = loadImage("ghostD.png");
  ghostU = loadImage("ghostU.png");
  ghost1R = loadImage("ghost1R.png");
  ghost1L = loadImage("ghost1L.png");
  ghost1D = loadImage("ghost1D.png");
  ghost1U = loadImage("ghost1U.png");
  ghost2R = loadImage("ghost2R.png");
  ghost2L = loadImage("ghost2L.png");
  ghost2D = loadImage("ghost2D.png");
  ghost2U = loadImage("ghost2U.png");
  ghost3R = loadImage("ghost3R.png");
  ghost3L = loadImage("ghost3L.png");
  ghost3D = loadImage("ghost3D.png");
  ghost3U = loadImage("ghost3U.png");
  scaredGhost1 = loadImage("scaredghost1.png");
  scaredGhost2 = loadImage("scaredghost2.png");
  scaredGhost3 = loadImage("scaredghost3.png");
  scaredGhost4 = loadImage("scaredghost4.png");
  pacman1 = loadImage("pacman1.png");
  pacman2 = loadImage("pacman2.png");
  pacman3 = loadImage("pacman3.png");
  pacman4 = loadImage("pacman4.png");
  pacman5 = loadImage("pacman5.png");
  pacman6 = loadImage("pacman6.png");
  pacman7 = loadImage("pacman7.png");
  pacman8 = loadImage("pacman8.png");
  pacman9 = loadImage("pacman9.png");
  pacman10 = loadImage("pacman10.png");
  pacman11 = loadImage("pacman11.png");
  pacman12 = loadImage("pacman12.png");

  //loading fonts
  crackman = createFont("crackman.regular.ttf", 50);
  pressStart = createFont("PressStart2P.ttf", 50);
  textFont(pressStart);
}

//-----------------------------------------------------------------------------------------------------------
// draw() FUNCTION
//-----------------------------------------------------------------------------------------------------------

void draw() {

  //all functions in game.pde
  if (!gameHasStarted) {
    preGame(); //show starting screen if game has not started
  } else if (!gameOver) {
    gameLoop(); //show game if game is not over
  } else {
    gameOver(); //post-game processing, allowing for restart
  }
}

//-----------------------------------------------------------------------------------------------------------
// serialEvent() FUNCTION
//-----------------------------------------------------------------------------------------------------------

void serialEvent(Serial myPort) {
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    inString = trim(inString); 
    int inputs[] = int(split(inString, ','));
    switchInput = inputs[0]; //first input (switches) is direction
    potInput = inputs[1]; //second input (potentiometer) used to change levels
  }
}

//-----------------------------------------------------------------------------------------------------------
// MISC. GAME FUNCTIONS (SCORING, WIN/LOSS CONDITIONS, MAKING GHOSTS VULNERABLE)
//-----------------------------------------------------------------------------------------------------------

//updates score based on number of food items eaten
void scoring() {
  int counter = 0;
  for (int i = 0; i < food.size(); i++) {
    if (food.get(i).eaten && !food.get(i).isFruit) {
      counter += 100;
    } else if (food.get(i).eaten) { //fruits are worth more
      counter += 400;
    }
  }
  SCORE = counter;
}

//checks if all food has been eaten (and player has won)
boolean checkWin() {
  boolean allEaten = true;
  for (int i = 0; i < food.size(); i++) {
    if (!food.get(i).eaten) {
      allEaten = false;
    }
  }
  return allEaten;
}

//checks if Pac-Man has collided with a ghost
//returns 0 for no collision, 1 for pacman eaten by ghost, 2 for ghost eaten by pacman
int checkCollision() {
  int collided = 0;
  for (int i = 0; i < ghosts.size(); i++) {
    if (pacman.xGrid == ghosts.get(i).xGrid && pacman.yGrid == ghosts.get(i).yGrid && ghosts.get(i).vulnerable == false) {
      collided = 1;
    } else if (pacman.xGrid == ghosts.get(i).xGrid && pacman.yGrid == ghosts.get(i).yGrid && ghosts.get(i).vulnerable == true) {
      ghosts.remove(i); 
      ghosts.add(new Ghost((int)random(8, 12), 10)); //ghost "dies" and respawns
      SCORE += 400;
      collided = 2; //not strictly necessary but I needed to return something
    }
  }
  return collided;
}

//makes ghosts vulnerable to pacman
int makeGhostsVulnerable() {
  for (int i = 0; i < ghosts.size(); i++) {
    ghosts.get(i).vulnerable = true;
  }
  return frameCount;
}

//makes ghosts invulnerable to pacman after a certain amount of time has elapsed
void makeGhostsNotVulnerable(int freezeFrame) {
  if (frameCount - freezeFrame > 5*frameRate) { //make vulnerable for 5 seconds
    for (int i = 0; i < ghosts.size(); i++) {
      ghosts.get(i).vulnerable = false;
    }
  }
}
