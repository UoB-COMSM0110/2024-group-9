class FogElement {
  int x, y;
  float speed;
  int levelWidth;
  int levelHeight;
  float opacity;
  float angle;
  float noiseScale;
  float noiseStrength;

  FogElement(int levelWidth, int levelHeight, float noiseScale, float noiseStrength) {
    this.levelWidth = levelWidth;
    this.levelHeight = levelHeight;
    this.opacity = random(0.6, 0.9);
    x = int(random(levelWidth));
    y = int(random(levelHeight));
    speed = random(1, 3);
    angle = random(TWO_PI); // Initial random direction
    this.noiseScale = noiseScale;
    this.noiseStrength = noiseStrength;
  }
  
  int getX() {
    return x;
  }
  
  int getY() {
    return y;
  }

  void update() {
    float noiseValue = noise(x * noiseScale, y * noiseScale);
    float angleChange = map(noiseValue, 0, 1, -PI/8, PI/8); // Change angle based on noise
    angle += angleChange;
    
    // Move the fog element based on the updated angle
    float dx = cos(angle) * speed;
    float dy = sin(angle) * speed;
    x += dx;
    y += dy;
    
    // Wrap around when reaching the edge of the screen
    if (x > levelWidth) {
      x = 0;
    } else if (x < 0) {
      x = levelWidth;
    }
    if (y > levelHeight) {
      y = 0;
    } else if (y < 0) {
      y = levelHeight;
    }
  }

  void display(int[] viewPos) {
    noStroke();
    fill(128, opacity * 255);
    ellipse(viewPos[0], viewPos[1], 60, 60);
   
  }
}
