public class PlayerControlledSprite extends Sprite{
  boolean landed = false;
  int nextDashTime = 0;
  boolean faceToRight = true;
  int health = 3;
  HashMap<String, Animation> animations;
  boolean doubleJump = true;//can or cant double jump
  boolean flagDoubleJump = false;//this jump is or not double jump
  boolean doubleJumped = false;
  float windFactor;
  int windConstant;
  HashMap<String, AudioPlayer> audioMap;

  // Constructor
  PlayerControlledSprite(int xPos, int yPos, int spriteWidth, int spriteHeight, int maxXPos, int maxYPos, String imgFile, HashMap<String, AudioPlayer> audioMap) {
    super(xPos, yPos, spriteWidth, spriteHeight, maxXPos, maxYPos, imgFile);
    this.health = health;
    this.animations = new HashMap<>();
    this.animations.put("standing", new Animation(game.getCharacter(), "standing"));
    this.animations.put("moving", new Animation(game.getCharacter(), "moving"));
    this.animations.put("jumping", new Animation(game.getCharacter(), "jumping"));
    this.audioMap = audioMap;
  }
  
  public void updatePosition(boolean moveLeft, boolean moveRight, boolean moveUp, boolean moveDown, boolean jump, NonPlayerControlledSprite[] sprites) {
    
      if (moveLeft) {
        if (xSpeed < -maxSpeedX * windFactor / 1.4f) {
          xSpeed += xAcceleration * windFactor;
        } else {
          if (xSpeed > 0) {
            xSpeed -= 2 * xAcceleration * windFactor;
          } else {
            xSpeed -= xAcceleration * windFactor;
          }
        }
        faceToRight = false;
      } else if (moveRight) {
          if (xSpeed > maxSpeedX / windFactor) {
            xSpeed -= xAcceleration * windFactor;
          } else {
            if (xSpeed < 0) {
              xSpeed += 2 * xAcceleration / windFactor;
            } else {
              xSpeed += xAcceleration / windFactor;
            }
          }
          faceToRight = true;
      } else {
          // Apply deceleration when no keys are pressed
          if (xSpeed > 0 - windConstant * windFactor * maxSpeedX / 5) {
              xSpeed -= xAcceleration * windFactor;
              xSpeed = max(0 - windConstant * windFactor * maxSpeedX / 5, xSpeed);
          } else if (xSpeed < 0 - windConstant * windFactor * maxSpeedX / 5) {
              xSpeed += xAcceleration * windFactor;
              xSpeed = min(0 - windConstant * windFactor * maxSpeedX / 5, xSpeed);
          }
      }

    ySpeed += yAcceleration;

    // Constrain speeds to their respective maximum values
    //xSpeed = constrain(xSpeed, -maxSpeedX, maxSpeedX);
    //ySpeed = constrain(ySpeed, -maxSpeedY, maxSpeedY);
    int currentTime = millis();

    if (moveUp && nextDashTime < currentTime) {
      audioMap.get("player_sprite.wav").play();
      audioMap.get("player_sprite.wav").rewind();
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
          audioMap.get("jump.wav").play();
          audioMap.get("jump.wav").rewind();
          ySpeed = -15.0f;
        }
        else if (flagDoubleJump) {
          audioMap.get("jump.wav").play();
          audioMap.get("jump.wav").rewind();
          ySpeed = -10.0f;
          flagDoubleJump = false;
          doubleJumped = true;
        }
      }
    
    if (!jump && !landed && !doubleJumped) {
      flagDoubleJump = true;
    }
    
    checkCollision(sprites);

    landed = false;

    // Update positions
    if (xPos + xSpeed > maxXPos || xPos + xSpeed < 0) {
      xSpeed = 0;
    }
    xPos += xSpeed;
    
    if (yPos + ySpeed > maxYPos || yPos + ySpeed < 0) {
      ySpeed = 0;
    }
    yPos += ySpeed;
  }
  
public void checkCollision(NonPlayerControlledSprite[] sprites) {
      
    for (NonPlayerControlledSprite sprite : sprites) {
        if (this.xPos + this.spriteWidth + this.xSpeed > sprite.xPos && this.xPos + this.xSpeed < sprite.xPos + sprite.spriteWidth && this.yPos + this.spriteHeight > sprite.yPos && this.yPos < sprite.yPos + sprite.spriteHeight) {
          if(sprite.isEnemy && sprite.isAlive){
            this.health = health - 1;
            if(health != 0 || game.section == SectionVariant.TUTORIAL){
              audioMap.get("player_hurt.wav").play();
              audioMap.get("player_hurt.wav").rewind();
            }
            else{
              audioMap.get("player_died.wav").play();
              audioMap.get("player_died.wav").rewind();
            }
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
      if (this.xPos + this.spriteWidth + this.xSpeed > sprite.xPos && this.xPos + this.xSpeed < sprite.xPos + sprite.spriteWidth && this.yPos + this.spriteHeight + this.ySpeed > sprite.yPos && this.yPos + this.ySpeed < sprite.yPos + sprite.spriteHeight) {
            this.ySpeed = 0.0;
            this.xSpeed = 0.0;
          }
    }
  }

  public boolean getFaceToRight() {
    return this.faceToRight;
  }
  
  public void setXAcceleration(float acceleration) {
    this.xAcceleration = acceleration;
  }
  
  public void setYAcceleration(float acceleration) {
    this.yAcceleration = acceleration;
  }
  
  public void setWindFactor(float windFactor) {
    this.windFactor = windFactor;
    if (windFactor - 1.0f > 0.0001f) {
      this.windConstant = 1;
    } else {
      this.windConstant = 0;
    }
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
