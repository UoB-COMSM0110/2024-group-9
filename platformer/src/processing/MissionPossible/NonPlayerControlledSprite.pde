public class NonPlayerControlledSprite extends Sprite{

  boolean isEnemy;
  boolean isAlive = true;
  boolean isSpaceshipPart;
  boolean faceToRight = false;
  int speed;
  
  // Constructor
  public NonPlayerControlledSprite(int xPos, int yPos, int spriteWidth, int spriteHeight, boolean isEnemy, boolean isSpaceshipPart, int maxXPos, int maxYPos, String imgFile, ModeVariant mode) {
    super(xPos, yPos, spriteWidth, spriteHeight, maxXPos, maxYPos, imgFile);
    this.isEnemy = isEnemy;
    this.isAlive = true;
    this.isSpaceshipPart = isSpaceshipPart;
    if (mode == ModeVariant.DIFFICULT) {
      this.speed += 3;
    }
  }
  
  public void Died(){
    this.isAlive = false;
    currentLevel.score += 5;
    AudioPlayer player = minim.loadFile("sounds/monster_died.wav");
    if(player != null){
      player.play();
    }
  }

  public void updatePosition(int leftBoundary, int rightBoundary){
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
