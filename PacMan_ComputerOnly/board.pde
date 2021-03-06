//2D array used to initialize board
char[][] BLUEPRINT = {
  {'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W'}, 
  {'W', 'P', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 'W', 'W', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 'P', 'W'}, 
  {'W', ' ', 'W', 'W', ' ', 'W', 'W', 'W', ' ', 'W', 'W', ' ', 'W', 'W', 'W', ' ', 'W', 'W', ' ', 'W'}, 
  {'W', ' ', 'W', 'W', ' ', 'W', 'W', 'W', ' ', 'W', 'W', ' ', 'W', 'W', 'W', ' ', 'W', 'W', ' ', 'W'}, 
  {'W', ' ', ' ', ' ', ' ', 'W', 'W', 'W', ' ', 'W', 'W', ' ', 'W', 'W', 'W', ' ', ' ', ' ', ' ', 'W'}, 
  {'W', 'W', 'W', 'W', ' ', ' ', ' ', ' ', ' ', 'P', ' ', ' ', ' ', ' ', ' ', ' ', 'W', 'W', 'W', 'W'}, 
  {'W', 'W', 'W', 'W', ' ', 'W', 'W', 'W', 'W', ' ', ' ', 'W', 'W', 'W', 'W', ' ', 'W', 'W', 'W', 'W'}, 
  {'W', 'W', 'W', 'W', ' ', 'W', 'W', 'W', 'W', ' ', ' ', 'W', 'W', 'W', 'W', ' ', 'W', 'W', 'W', 'W'}, 
  {'W', 'W', 'W', 'W', ' ', 'W', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', 'W', ' ', 'W', 'W', 'W', 'W'}, 
  {'W', 'W', 'W', 'W', ' ', ' ', ' ', 'W', 'W', ' ', ' ', 'W', 'W', ' ', ' ', ' ', 'W', 'W', 'W', 'W'}, 
  {' ', ' ', ' ', ' ', ' ', 'W', ' ', 'W', 'G', 'G', 'G', 'G', 'W', ' ', 'W', ' ', ' ', ' ', ' ', ' '}, 
  {'W', 'W', 'W', 'W', ' ', 'W', ' ', 'W', 'W', 'W', 'W', 'W', 'W', ' ', 'W', ' ', 'W', 'W', 'W', 'W'}, 
  {'W', 'W', 'W', 'W', ' ', ' ', ' ', ' ', ' ', 'P', ' ', ' ', ' ', ' ', ' ', ' ', 'W', 'W', 'W', 'W'}, 
  {'W', 'W', 'W', 'W', ' ', 'W', ' ', 'W', 'W', 'W', 'W', 'W', 'W', ' ', 'W', ' ', 'W', 'W', 'W', 'W'}, 
  {'W', ' ', ' ', ' ', ' ', 'W', ' ', 'W', 'W', 'W', 'W', 'W', 'W', ' ', 'W', ' ', ' ', ' ', ' ', 'W'}, 
  {'W', ' ', 'W', 'W', ' ', 'W', ' ', ' ', 'W', 'W', 'W', 'W', ' ', ' ', 'W', ' ', 'W', 'W', ' ', 'W'}, 
  {'W', ' ', 'W', 'W', ' ', 'W', 'W', ' ', ' ', ' ', ' ', ' ', ' ', 'W', 'W', ' ', 'W', 'W', ' ', 'W'}, 
  {'W', ' ', 'W', 'W', ' ', ' ', ' ', ' ', 'W', 'W', 'W', 'W', ' ', ' ', ' ', ' ', 'W', 'W', ' ', 'W'}, 
  {'W', 'P', ' ', ' ', ' ', 'W', 'W', ' ', ' ', ' ', ' ', ' ', ' ', 'W', 'W', ' ', ' ', ' ', 'P', 'W'}, 
  {'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W', 'W'}, 
};

//wall constructor
class Wall {
  int xGrid;
  int yGrid;

  Wall(int x, int y) {
    xGrid = x;
    yGrid = y;
  }

  //walls drawn as solid squares
  void drawWall() {
    fill(50, 66, 168);
    stroke(50, 66, 168);
    square(xGrid*GRID_SIZE, yGrid*GRID_SIZE, GRID_SIZE);
  }
}
