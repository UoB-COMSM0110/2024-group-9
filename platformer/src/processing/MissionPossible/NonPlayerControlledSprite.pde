public class NonPlayerControlledSprite extends Sprite{

  boolean isEnemy;
  boolean isCollectiblePart;
  boolean isCollected=false;
  
  // Constructor
  public NonPlayerControlledSprite(int xPos, int yPos, int spriteWidth, int spriteHeight, int spriteLayer, boolean isEnemy, boolean isCollectibePart, int maxXPos, int maxYPos, String imgFile) {
    super(xPos, yPos, spriteWidth, spriteHeight, spriteLayer, maxXPos, maxYPos, imgFile);
    this.isEnemy = isEnemy;
    this.isCollectiblePart = isCollectiblePart;
  }

}
