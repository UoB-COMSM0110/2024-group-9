public class NonPlayerControlledSprite extends Sprite{

  boolean isEnemy;
  
  // Constructor
  public NonPlayerControlledSprite(int xPos, int yPos, int spriteWidth, int spriteHeight, int spriteLayer, boolean isEnemy, int maxXPos, int maxYPos, String imgFile) {
    super(xPos, yPos, spriteWidth, spriteHeight, spriteLayer, maxXPos, maxYPos, imgFile);
    this.isEnemy = isEnemy;
  }

}
