class Wind {
  int x, y;
  float speed;
  int levelWidth;
  int levelHeight;

  Wind(int levelWidth, int levelHeight) {
    this.levelWidth = levelWidth;
    this.levelHeight = levelHeight;
    x = int(random(levelWidth));
    y = int(random(levelHeight));
    speed = 8;
  }
  
  int getX() {
    return x;
  }
  
  int getY() {
    return y;
  }
  

  void update() {
    x -= speed;
    if (x < 0) {
      y = int(random(levelHeight));
      x = levelWidth;
    }
  }

  void display(int[] viewPos) {
    noStroke();
    fill(255);
    ellipse(viewPos[0], viewPos[1], 8, 8);
  }
}
