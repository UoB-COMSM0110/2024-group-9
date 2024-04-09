class FallingSnowflake {
  int x, y;
  float speed;
  int levelWidth;
  int levelHeight;

  FallingSnowflake(int levelWidth, int levelHeight) {
    this.levelWidth = levelWidth;
    this.levelHeight = levelHeight;
    x = int(random(levelWidth));
    y = -int(random(levelHeight));
    speed = random(5, 10);
  }
  
  int getX() {
    return x;
  }
  
  int getY() {
    return y;
  }
  

  void update() {
    y += speed;
    if (y > levelHeight) {
      y = -int(random(levelHeight));
      x = int(random(levelWidth));
    }
  }

  void display(int[] viewPos) {
    noStroke();
    fill(255);
    ellipse(viewPos[0], viewPos[1], 8, 8);
  }
}
