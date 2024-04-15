//class FogLayer {
//  float speed;
//  int density;
//  int colour;
//  float opacity;
//  int yPos;
//  float directionChangeChance = 0.01; // Chance of changing direction per frame
//  float currentDirection;

//  FogLayer(float speed, int density, int colour, float opacity) {
//    this.speed = speed;
//    this.density = density;
//    this.colour = colour;
//    this.opacity = opacity;
//    this.yPos = 0;
//    this.currentDirection = random(TWO_PI); // Initialize with random direction
//  }

//  void update() {
//    // Move the fog layer in the current direction
//    yPos += speed * cos(currentDirection);
    
//    // Gradually change direction with a small chance
//    if (random(1) < directionChangeChance) {
//      currentDirection += random(-PI/64, PI/64); // Adjust direction slightly
//    }

//    // Ensure yPos stays within bounds
//    if (yPos > height - density) {
//      yPos = -density;
//    } else if (yPos < -density) {
//      yPos = height + density;
//    }
//  }
  
//  void display() {
//    fill(colour, (int)(255 * opacity)); // Set fill color with adjusted opacity
//    rect(0, yPos, width, density); // Draw fog layer as a rectangle
//    println(yPos);
//  }
//}

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
