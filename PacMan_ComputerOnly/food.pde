class Food {
  int xGrid;
  int yGrid;
  //generic fruit or not bool
  boolean isFruit = false;
  //specific fruit bool, used for drawing
  boolean isFruit1 = false;
  boolean isFruit2 = false;
  boolean isFruit3 = false;
  boolean isFruit4 = false;
  boolean isFruit5 = false;
  boolean isFruit6 = false;
  boolean eaten;

  //constructor, one food item per grid square, all food begins as uneaten
  Food(int i, int j) {
    xGrid = i;
    yGrid = j;
    //fruits spawn 0.75% of the time
    if (random(1) < 0.00125) {
      isFruit1 = true;
      isFruit = true;
    } else if (random(1) < 0.0025) {
      isFruit2 = true;
      isFruit = true;
    } else if (random(1) < 0.00375) {
      isFruit3 = true;
      isFruit = true;
    } else if (random(1) < 0.005) {
      isFruit4 = true;
      isFruit = true;
    } else if (random(1) < 0.00675) {
      isFruit5 = true;
      isFruit = true;
    } else if (random(1) < 0.0075) {
      isFruit6 = true;
      isFruit = true;
    }
    eaten = false;
  }

  //only draw uneaten food
  void drawFood() {
    if (!eaten && !isFruit) {
      fill(255);
      circle(xGrid*GRID_SIZE + GRID_SIZE/2, yGrid*GRID_SIZE + GRID_SIZE/2, 4);
    } else if (!eaten && isFruit1) { //drawing fruits
      image(fruit1, xGrid*GRID_SIZE + 5, yGrid*GRID_SIZE + 5, 30, 30);
    } else if (!eaten && isFruit2) {
      image(fruit2, xGrid*GRID_SIZE + 5, yGrid*GRID_SIZE + 5, 30, 30);
    } else if (!eaten && isFruit3) {
      image(fruit3, xGrid*GRID_SIZE + 5, yGrid*GRID_SIZE + 5, 30, 30);
    } else if (!eaten && isFruit4) {
      image(fruit4, xGrid*GRID_SIZE + 5, yGrid*GRID_SIZE + 5, 30, 30);
    } else if (!eaten && isFruit5) {
      image(fruit5, xGrid*GRID_SIZE + 5, yGrid*GRID_SIZE + 5, 30, 30);
    } else if (!eaten && isFruit6) {
      image(fruit6, xGrid*GRID_SIZE + 5, yGrid*GRID_SIZE + 5, 30, 30);
    }
  }

  //if pacman and food have same xGrid and yGrid values, mark food as eaten
  void checkEaten(int i) {
    if (pacman.xGrid == food.get(i).xGrid && pacman.yGrid == food.get(i).yGrid) 
    {
      food.get(i).eaten = true;
    }
  }
}
