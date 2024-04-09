public class NonPlayerControlledSprite extends Sprite{

  boolean isEnemy;
  boolean isAlive = true;
  
  // Constructor
  public NonPlayerControlledSprite(int xPos, int yPos, int spriteWidth, int spriteHeight, int spriteLayer, boolean isEnemy, int maxXPos, int maxYPos, String imgFile) {
    super(xPos, yPos, spriteWidth, spriteHeight, spriteLayer, maxXPos, maxYPos, imgFile);
    this.isEnemy = isEnemy;
    this.isAlive = isAlive;
  }
  public void Died(){
    this.isAlive = false;
  }
  public void updatePosition(){
    if(isEnemy && !isAlive){
      this.xPos = 9999;
      this.yPos = 9999;
    }
  }
}
