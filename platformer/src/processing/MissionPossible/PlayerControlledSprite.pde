public class PlayerControlledSprite extends Sprite{

  // Constructor
  PlayerControlledSprite(int xPos, int yPos, int spriteWidth, int spriteHeight, int spriteLayer, int maxXPos, int maxYPos) {
    super(xPos, yPos, spriteWidth, spriteHeight, spriteLayer, maxXPos, maxYPos);
  }
  
  public void updatePosition(boolean moveLeft, boolean moveRight, boolean moveUp, boolean moveDown, Sprite[] sprites) {
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
    
    checkCollision(sprites);

    // Update positions
    xPos += xSpeed;
    xPos = constrain(xPos, 0, maxXPos - spriteWidth);
    yPos += ySpeed;
    yPos = constrain(yPos, 0, maxYPos - spriteHeight);

  }
  
public void checkCollision(Sprite[] sprites) {
    
    for (Sprite sprite : sprites) {
        if (this.xPos + this.spriteWidth + this.xSpeed > sprite.xPos && this.xPos + this.xSpeed < sprite.xPos + sprite.spriteWidth && this.yPos + this.spriteHeight > sprite.yPos && this.yPos < sprite.yPos + sprite.spriteHeight) {
          this.xSpeed = 0;
        }
        if (this.xPos + this.spriteWidth > sprite.xPos && this.xPos < sprite.xPos + sprite.spriteWidth && this.yPos + this.spriteHeight + this.ySpeed > sprite.yPos && this.yPos + this.ySpeed < sprite.yPos + sprite.spriteHeight) {
          this.ySpeed = 0;
        }
    }
}
}
