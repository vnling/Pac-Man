class Food {

  //constructor, one food item per grid square, all food begins as uneaten
  constructor(i, j) {
    this.xGrid = i;
    this.yGrid = j;
    //fruits spawn 0.75% of the time
    if (random(1) < 0.00125) {
      this.isFruit1 = true;
      this.isFruit = true;
    } else if (random(1) < 0.0025) {
      this.isFruit2 = true;
      this.isFruit = true;
    } else if (random(1) < 0.00375) {
      this.isFruit3 = true;
      this.isFruit = true;
    } else if (random(1) < 0.005) {
      this.isFruit4 = true;
      this.isFruit = true;
    } else if (random(1) < 0.00675) {
      this.isFruit5 = true;
      this.isFruit = true;
    } else if (random(1) < 0.0075) {
      this.isFruit6 = true;
      this.isFruit = true;
    }
    this.eaten = false;
  }

  //only draw uneaten food
  drawFood() {
    if (!this.eaten && !this.isFruit) {
      stroke(255);
      fill(255);
      circle(this.xGrid*GRID_SIZE + GRID_SIZE/2, this.yGrid*GRID_SIZE + GRID_SIZE/2, 4);
    } else if (!this.eaten && this.isFruit1) { //drawing fruits
      image(fruit1, this.xGrid*GRID_SIZE + 5, this.yGrid*GRID_SIZE + 5, 30, 30);
    } else if (!this.eaten && this.isFruit2) {
      image(fruit2, this.xGrid*GRID_SIZE + 5, this.yGrid*GRID_SIZE + 5, 30, 30);
    } else if (!this.eaten && this.isFruit3) {
      image(fruit3, this.xGrid*GRID_SIZE + 5, this.yGrid*GRID_SIZE + 5, 30, 30);
    } else if (!this.eaten && this.isFruit4) {
      image(fruit4, this.xGrid*GRID_SIZE + 5, this.yGrid*GRID_SIZE + 5, 30, 30);
    } else if (!this.eaten && this.isFruit5) {
      image(fruit5, this.xGrid*GRID_SIZE + 5, this.yGrid*GRID_SIZE + 5, 30, 30);
    } else if (!this.eaten && this.isFruit6) {
      image(fruit6, this.xGrid*GRID_SIZE + 5, this.yGrid*GRID_SIZE + 5, 30, 30);
    }
  }

  //if pacman and food have same xGrid and yGrid values, mark food as eaten
  checkEaten(i) {
    if (pacman.xGrid == food[i].xGrid && pacman.yGrid == food[i].yGrid) 
    {
      food[i].eaten = true;
    }
  }
}