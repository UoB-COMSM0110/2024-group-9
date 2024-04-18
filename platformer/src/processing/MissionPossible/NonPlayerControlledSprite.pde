public class NonPlayerControlledSprite extends Sprite{

  boolean isEnemy;
  boolean isAlive = true;
  boolean isSpaceshipPart;
  boolean faceToRight = false;
  float speed;
  
  // Constructor
  public NonPlayerControlledSprite(int xPos, int yPos, int spriteWidth, int spriteHeight, boolean isEnemy, boolean isSpaceshipPart, int maxXPos, int maxYPos, String imgFile) {
    super(xPos, yPos, spriteWidth, spriteHeight, maxXPos, maxYPos, imgFile);
    this.isEnemy = isEnemy;
    this.isAlive = true;
    this.isSpaceshipPart = isSpaceshipPart;
  }
  public void Died(){
    this.isAlive = false;
    currentLevel.score += 5;
  }

  public void updatePosition(int leftBoundary, int rightBoundary){
    if(game.mode == ModeVariant.DIFFICULT){
      speed = 5;
    }
    else{
      speed = 3;
    }
    if((isEnemy || isSpaceshipPart) && !isAlive){
      this.xPos = 9999;
      this.yPos = 9999;
    }
    if(isEnemy && isAlive){
      if(this.xPos > leftBoundary && !faceToRight){
        this.xPos -= speed;
      }
      if(this.xPos - speed <= leftBoundary){
        faceToRight = true;
      }
      if(this.xPos < rightBoundary && faceToRight){
        this.xPos += speed;
      }
      if(this.xPos + speed >= rightBoundary){
        faceToRight = false;
      }
    }

  }
}
