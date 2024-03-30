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
    
    //checkCollision(sprites);

    // Update positions
    if(checkCollisionBoolean(sprites, xPos + xSpeed, yPos, spriteWidth, spriteHeight) == false){
      xPos += xSpeed;
    }
    else{
      xSpeed = 0;
    }
    xPos = constrain(xPos, 0, maxXPos - spriteWidth);
    if(checkCollisionBoolean(sprites, xPos, yPos + ySpeed, spriteWidth, spriteHeight) == false){
      yPos += ySpeed;
    }
    else{
      ySpeed = 0;
    }
    yPos = constrain(yPos, 0, maxYPos - spriteHeight);

  }
  
public boolean checkCollisionBoolean(Sprite[] sprites, float px, float py, float pw, float ph) {
  for (Sprite sprite : sprites) {
    if (px + pw > sprite.xPos && px < sprite.xPos + sprite.spriteWidth && py + ph > sprite.yPos && py < sprite.yPos + sprite.spriteHeight) {
      return true; // Collision detected
    }
  }
  return false; // No collision detected
}

  
//public void checkCollision(Sprite[] sprites) {
//    boolean collideLeft;
//    boolean collideRight;
//    boolean collideTop;
//    boolean collideBottom;
    
//    for (Sprite sprite : sprites) {
//        collideBottom = this.yPos + this.spriteHeight > sprite.yPos &&
//                     this.yPos < sprite.yPos + sprite.spriteHeight &&
//                     this.xPos < sprite.xPos + sprite.spriteWidth &&
//                     this.xPos + this.spriteWidth > sprite.xPos;

//        collideTop = this.yPos > sprite.yPos &&
//                        this.yPos < sprite.yPos + sprite.spriteHeight &&
//                        this.xPos < sprite.xPos + sprite.spriteWidth &&
//                        this.xPos + this.spriteWidth > sprite.xPos;

//        collideRight = this.xPos < sprite.xPos + sprite.spriteWidth &&
//                      this.xPos + this.spriteWidth > sprite.xPos &&
//                      this.yPos < sprite.yPos + sprite.spriteHeight &&
//                      this.yPos + this.spriteHeight > sprite.yPos;

//        collideLeft = this.xPos + this.spriteWidth > sprite.xPos &&
//                       this.xPos < sprite.xPos + sprite.spriteWidth &&
//                       this.yPos < sprite.yPos + sprite.spriteHeight &&
//                       this.yPos + this.spriteHeight > sprite.yPos;

        // Handle collisions based on the boolean variables
        //if (collideTop) {
        //    //this.yPos = sprite.yPos + sprite.spriteHeight; // Move player below colliding sprite
        //    this.ySpeed = -ySpeed; // Stop upward movement
        //}

        //if (collideBottom) {
        //    //this.yPos = sprite.yPos - this.spriteHeight; // Move player above colliding sprite
        //    this.ySpeed = -ySpeed; // Stop downward movement
        //}

        //if (collideLeft) {
        //    //this.xPos = sprite.xPos + sprite.spriteWidth; // Move player to the right of colliding sprite
        //    this.xSpeed = -xSpeed; // Stop leftward movement
        //}

        //if (collideRight) {
        //    //this.xPos = sprite.xPos - this.spriteWidth; // Move player to the left of colliding sprite
        //    this.xSpeed = -xSpeed; // Stop rightward movement
        //}
//    }
//}
}
