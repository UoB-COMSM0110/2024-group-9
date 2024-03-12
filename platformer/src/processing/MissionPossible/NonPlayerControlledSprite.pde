public class NonPlayerControlledSprite extends Sprite{

  boolean isEnemy;
  
  // Constructor
  public NonPlayerControlledSprite(int xPos, int yPos, int spriteWidth, int spriteHeight, int spriteLayer, boolean isEnemy) {
    super(xPos, yPos, spriteWidth, spriteHeight, spriteLayer);
    this.isEnemy = isEnemy;
  }

}
