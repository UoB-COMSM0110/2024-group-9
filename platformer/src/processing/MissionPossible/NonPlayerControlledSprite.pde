public class NonPlayerControlledSprite extends Sprite{

  boolean isEnemy;
  
  // Constructor
  public NonPlayerControlledSprite(int xPos, int yPos, int spriteWidth, int spriteHeight, int spriteLayer, String shape) {
    super(xPos, yPos, spriteWidth, spriteHeight, spriteLayer, shape);
    this.isEnemy = isEnemy;
  }

}
