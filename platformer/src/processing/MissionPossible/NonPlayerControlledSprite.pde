public class NonPlayerControlledSprite extends Sprite{

  boolean isEnemy;
  boolean isAlive = true;
  boolean isSpaceshipPart;
  
  // Constructor
  public NonPlayerControlledSprite(int xPos, int yPos, int spriteWidth, int spriteHeight, int spriteLayer, boolean isEnemy, boolean isSpaceshipPart, int maxXPos, int maxYPos, String imgFile) {
    super(xPos, yPos, spriteWidth, spriteHeight, spriteLayer, maxXPos, maxYPos, imgFile);
    this.isEnemy = isEnemy;
    this.isAlive = true;
    this.isSpaceshipPart = isSpaceshipPart;
  }
  public void Died(){
    this.isAlive = false;
    currentLevel.score += 5;
  }
  public void updatePosition(){
    if((isEnemy || isSpaceshipPart) && !isAlive){
      this.xPos = 9999;
      this.yPos = 9999;
    }
  }
}
