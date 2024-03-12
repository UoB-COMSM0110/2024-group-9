public abstract class Sprite{
  int xPos;
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
  int spriteLayer; // 0 is in background, 1 is in foreground and will interact with player Sprite
  float health; // Move to PlayerControlledSprite if only player has health
  float damage;
  boolean onGround;
  boolean collision;
  PImage image;
  
  public Sprite(int xPos, int yPos, int spriteWidth, int spriteHeight, int spriteLayer) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.spriteWidth = spriteWidth;
    this.spriteHeight = spriteHeight;
    this.spriteLayer = spriteLayer;
    this.xAcceleration = 0.1f;
    this.yAcceleration = 0.1f;
    this.maxSpeedX = 5.0f;
    this.maxSpeedY = 5.0f;
  }
  
      // Update the position based on speed and acceleration
  public void updatePosition(boolean moveLeft, boolean moveRight, boolean moveUp, boolean moveDown) {
      // Update x position
      if (moveLeft) {
          xSpeed -= xAcceleration;
      } else if (moveRight) {
          xSpeed += xAcceleration;
      } else {
          // Apply deceleration when no keys are pressed
          if (xSpeed > 0) {
              xSpeed -= xAcceleration;
              xSpeed = Math.max(0, xSpeed);
          } else if (xSpeed < 0) {
              xSpeed += xAcceleration;
              xSpeed = Math.min(0, xSpeed);
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
              ySpeed = Math.max(0, ySpeed);
          } else if (ySpeed < 0) {
              ySpeed += yAcceleration;
              ySpeed = Math.min(0, ySpeed);
          }
      }

    // Constrain speeds to their respective maximum values
    xSpeed = constrain(xSpeed, -maxSpeedX, maxSpeedX);
    ySpeed = constrain(ySpeed, -maxSpeedY, maxSpeedY);

    // Update positions
    xPos += xSpeed;
    yPos += ySpeed;
  }
  
  public int getXPos() {
    return this.xPos;
  }
  
  public int getYPos() {
    return this.yPos;
  }
    

    // Utility function to constrain a value within a given range
    private float constrain(float value, float min, float max) {
        return Math.max(min, Math.min(value, max));
    }
  
}
