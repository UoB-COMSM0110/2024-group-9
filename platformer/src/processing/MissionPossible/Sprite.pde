public abstract class Sprite{
  int xPos;
  int maxXPos;
  int maxYPos;
  int yPos;
  float speed;
  float yAcceleration;
  float xAcceleration;
  float xSpeed;
  float ySpeed;
  float maxSpeedX;
  float maxSpeedY;
  int spriteWidth;
  int spriteHeight;
  float health; // Move to PlayerControlledSprite if only player has health
  float damage;
  boolean onGround;
  boolean collision;
  String image;
  
  public Sprite(int xPos, int yPos, int spriteWidth, int spriteHeight, int maxXPos, int maxYPos, String imgFile) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.spriteWidth = spriteWidth;
    this.spriteHeight = spriteHeight;
    this.xAcceleration = 0.1f;
    this.yAcceleration = 0.5f;
    this.maxSpeedX = 7.0f;
    this.maxSpeedY = 20.0f;
    this.maxXPos = maxXPos;
    this.maxYPos = maxYPos;
    this.image = imgFile;
    
  }
  
      // Update the position based on speed and acceleration
  public void updatePosition(boolean moveLeft, boolean moveRight, boolean moveUp, boolean moveDown, boolean jump) {
      // Update x position
      if (moveLeft) {
          xSpeed -= xAcceleration;
      } else if (moveRight) {
          xSpeed += xAcceleration;
      } else {
          // Apply deceleration when no keys are pressed
          if (xSpeed > 0) {
              xSpeed -= xAcceleration;
              xSpeed = max(0, xSpeed);
          } else if (xSpeed < 0) {
              xSpeed += xAcceleration;
              xSpeed = min(0, xSpeed);
          }
      }
  
      // Update y position
      if (moveUp) {
          ySpeed -= yAcceleration;
      } else if (moveDown) {
          ySpeed += yAcceleration;
      } else {
          // Apply deceleration when no keys are pressed
          if (ySpeed > 0) {
              ySpeed -= yAcceleration;
              ySpeed = max(0, ySpeed);
          } else if (ySpeed < 0) {
              ySpeed += yAcceleration;
              ySpeed = min(0, ySpeed);
          }
      }

    // Constrain speeds to their respective maximum values
    xSpeed = constrain(xSpeed, -maxSpeedX, maxSpeedX);
    ySpeed = constrain(ySpeed, -maxSpeedY, maxSpeedY);

    // Update positions
    xPos += xSpeed;
    xPos = constrain(xPos, 0, maxXPos - spriteWidth);
    yPos += ySpeed;
    yPos = constrain(yPos, 0, maxYPos - spriteHeight);
  }
  
  public int getXPos() {
    return this.xPos;
  }
  
  public int getYPos() {
    return this.yPos;
  }
  
  public int getSpriteWidth() {
    return this.spriteWidth;
  }
  
}
