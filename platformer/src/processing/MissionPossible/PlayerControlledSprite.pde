public class PlayerControlledSprite extends Sprite{
  boolean landed = false;
  int nextDashTime = 0;
  boolean faceToRight = true;
  int health = 3;
  HashMap<String, Animation> animations;
  boolean doubleJump = true;//can or cant double jump
  boolean flagDoubleJump = false;//this jump is or not double jump
  boolean doubleJumped = false;

  // Constructor
  PlayerControlledSprite(int xPos, int yPos, int spriteWidth, int spriteHeight, int spriteLayer, int maxXPos, int maxYPos, String imgFile) {
    super(xPos, yPos, spriteWidth, spriteHeight, spriteLayer, maxXPos, maxYPos, imgFile);
    this.health = health;
    this.animations = new HashMap<>();
    this.animations.put("standing", new Animation(game.getCharacter(), "standing"));
    this.animations.put("moving", new Animation(game.getCharacter(), "moving"));
    this.animations.put("jumping", new Animation(game.getCharacter(), "jumping"));
  }
  
  public void updatePosition(boolean moveLeft, boolean moveRight, boolean moveUp, boolean moveDown, boolean jump, NonPlayerControlledSprite[] sprites) {
    
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
        faceToRight = false;
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
          faceToRight = true;
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
      if (faceToRight) {
        xSpeed = 16.0f;
        nextDashTime = currentTime + 3000; // Dash every 3s
      } else {
        xSpeed = -16.0f;
        nextDashTime = currentTime + 3000; // Dash every 3s
      }
    }
   
    
    checkCollision(sprites);
    
    if (jump) {
        if(landed) {
          ySpeed = -15.0f;
        }
        else if (flagDoubleJump) {
          ySpeed = -10.0f;
          flagDoubleJump = false;
          doubleJumped = true;
        }
      }
    
    if (!jump && !landed && !doubleJumped) {
      flagDoubleJump = true;
    }
    



    landed = false;

    // Update positions
    xPos += xSpeed;
    xPos = constrain(xPos, 0, maxXPos - spriteWidth);
    yPos += ySpeed;
    yPos = constrain(yPos, 0, maxYPos - spriteHeight);

  }
  
public void checkCollision(NonPlayerControlledSprite[] sprites) {
    
    for (NonPlayerControlledSprite sprite : sprites) {
        if (this.xPos + this.spriteWidth + this.xSpeed > sprite.xPos && this.xPos + this.xSpeed < sprite.xPos + sprite.spriteWidth && this.yPos + this.spriteHeight > sprite.yPos && this.yPos < sprite.yPos + sprite.spriteHeight) {
          if(sprite.isEnemy && sprite.isAlive){
            this.health = health - 1;
            this.xSpeed = Math.signum(this.xSpeed) * -1 * this.maxSpeedX;
            this.ySpeed = Math.signum(this.ySpeed) * -0.5 * this.maxSpeedY;
          } else if(sprite.isSpaceshipPart && sprite.isAlive){
            collectSpaceshipPart(sprite);
          } else {
            this.xSpeed = 0;
          }

        }     
        if (this.xPos + this.spriteWidth > sprite.xPos && this.xPos < sprite.xPos + sprite.spriteWidth && this.yPos + this.spriteHeight + this.ySpeed > sprite.yPos && this.yPos + this.ySpeed < sprite.yPos + sprite.spriteHeight) {
          if(sprite.isEnemy){
            sprite.Died();
            this.xSpeed = Math.signum(this.xSpeed) * -1 * this.maxSpeedX;
            this.ySpeed = Math.signum(this.ySpeed) * -0.5 * this.maxSpeedY;
          } else if(sprite.isSpaceshipPart && sprite.isAlive){
            collectSpaceshipPart(sprite);
          } else {
            this.ySpeed = 0.0;
            if (this.yPos + this.spriteHeight < sprite.yPos + 0.1) {
              this.landed = true;
              this.flagDoubleJump = false;
              this.doubleJumped = false;
            }
          }
        }
    }
  }

  public boolean getFaceToRight() {
    return this.faceToRight;
  }
  
  public PImage getNextFrame() {
    if (Math.abs(ySpeed) - 0 > 0.0001) {
      return this.animations.get("jumping").nextFrame(ySpeed / 5);
    } else if (Math.abs(xSpeed) - 0 < 0.0001) {
      return this.animations.get("standing").nextFrame(1);
    }
    return this.animations.get("moving").nextFrame(xSpeed / 3);
  }
  
  public void collectSpaceshipPart(NonPlayerControlledSprite sprite){
    sprite.Died();
    game.increaseSpaceshipPieces();
    String part = "part"+game.level.substring(5);
    currentView.userInterface.getElement(part).setTintAmount(255);
    currentLevel.endLevel();
  }
  
}
