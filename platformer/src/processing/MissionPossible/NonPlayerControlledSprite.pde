public class NonPlayerControlledSprite extends Sprite{

  boolean isEnemy;
  boolean isAlive = true;
  boolean faceToRight = false;
  int speed = 5;
  
  // Constructor
  public NonPlayerControlledSprite(int xPos, int yPos, int spriteWidth, int spriteHeight, int spriteLayer, boolean isEnemy, int maxXPos, int maxYPos, String imgFile) {
    super(xPos, yPos, spriteWidth, spriteHeight, spriteLayer, maxXPos, maxYPos, imgFile);
    this.isEnemy = isEnemy;
    this.isAlive = isAlive;
  }
  public void Died(){
    this.isAlive = false;
    currentLevel.score += 5;
  }
  public void updatePosition(int leftBoundary, int rightBoundary){
    if(isEnemy && !isAlive){
      this.xPos = 9999;
      this.yPos = 9999;
    }
    if(isEnemy && isAlive){
      if(this.xPos > leftBoundary && !faceToRight){
        this.xPos -= speed;
      }
      if(this.xPos == leftBoundary){
        faceToRight = true;
      }
      if(this.xPos < rightBoundary && faceToRight){
        this.xPos += speed;
      }
      if(this.xPos == rightBoundary){
        faceToRight = false;
      }
    }

  }
}
