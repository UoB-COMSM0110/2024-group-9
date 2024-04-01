public class PlayerControlledSprite extends Sprite{
  boolean landed = false;
  int nextDashTime = 0;

  // Constructor
  PlayerControlledSprite(int xPos, int yPos, int spriteWidth, int spriteHeight, int spriteLayer, int maxXPos, int maxYPos, String imgFile) {
    super(xPos, yPos, spriteWidth, spriteHeight, spriteLayer, maxXPos, maxYPos, imgFile);
  }
  
  public void updatePosition(boolean moveLeft, boolean moveRight, boolean moveUp, boolean moveDown, boolean jump, Sprite[] sprites) {
    
      if (moveLeft) {
        if (xSpeed < -maxSpeedX) {
          xSpeed += xAcceleration;
        } else {
          if (xSpeed > 0) {
            xSpeed -= 2 * xAcceleration;
          } else {
            xSpeed -= xAcceleration;
          }
        }
      } else if (moveRight) {
          if (xSpeed > maxSpeedX) {
            xSpeed -= xAcceleration;
          } else {
            if (xSpeed < 0) {
              xSpeed += 2 * xAcceleration;
            } else {
              xSpeed += xAcceleration;
            }
          }
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

    ySpeed += yAcceleration;

    // Constrain speeds to their respective maximum values
    //xSpeed = constrain(xSpeed, -maxSpeedX, maxSpeedX);
    //ySpeed = constrain(ySpeed, -maxSpeedY, maxSpeedY);
    int currentTime = millis();

    if (moveUp && nextDashTime < currentTime) {
      if (moveRight) {
        xSpeed = 16.0f;
        nextDashTime = currentTime + 3000; // Dash every 3s
      } else if (moveLeft) {
        xSpeed = -16.0f;
        nextDashTime = currentTime + 3000; // Dash every 3s
      }
    }
   
    
    checkCollision(sprites);
    
    if (jump && landed) {
      ySpeed = -15.0f;
    }
    



    landed = false;

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
          this.ySpeed = 0.0;
          if (this.yPos + this.spriteHeight < sprite.yPos + 0.1) {
            this.landed = true;
          }
          
        }
    }
    
}
}
