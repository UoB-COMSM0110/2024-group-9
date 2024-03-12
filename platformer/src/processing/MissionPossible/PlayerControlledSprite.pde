public class PlayerControlledSprite extends Sprite{

  // Constructor
  PlayerControlledSprite(int xPos, int yPos, int spriteWidth, int spriteHeight, int spriteLayer) {
    super(xPos, yPos, spriteWidth, spriteHeight, spriteLayer);
  }
  
  public void updatePosition(boolean moveLeft, boolean moveRight, boolean moveUp, boolean moveDown) {
    super.updatePosition(moveLeft, moveRight, moveUp, moveDown);
  }

}
