public class PlayerControlledSprite extends Sprite{

  // Constructor
  PlayerControlledSprite(int xPos, int yPos, int spriteWidth, int spriteHeight, int spriteLayer, int maxXPos, int maxYPos) {
    super(xPos, yPos, spriteWidth, spriteHeight, spriteLayer, maxXPos, maxYPos);
  }
  
  public void updatePosition(boolean moveLeft, boolean moveRight, boolean moveUp, boolean moveDown) {
    super.updatePosition(moveLeft, moveRight, moveUp, moveDown);
  }

}
