public class View {
    private final Camera camera;
    Level currentLevel;

    View(Level currentLevel) {
        this.camera = new Camera(0, 0);
        this.currentLevel = currentLevel;
    }
    
    public void displayView() {
      if (key == 'w') {
        this.camera.setPos(this.camera.getXPos(), this.camera.getYPos() - 1);
      } else if (key == 's') {
        this.camera.setPos(this.camera.getXPos(), this.camera.getYPos() + 1);
      } else if (key == 'a') {
        this.camera.setPos(this.camera.getXPos() - 1, this.camera.getYPos());
      } else if (key == 'd') {
        this.camera.setPos(this.camera.getXPos() + 1, this.camera.getYPos());
      }
      for (int sprite = 0; sprite < currentLevel.sprites.length; sprite++) {
        int[] currentSpriteViewPos = spriteViewPos(currentLevel.sprites[sprite]);
        if (currentLevel.sprites[sprite].shape.equals("square")) {

          square(currentSpriteViewPos[0], currentSpriteViewPos[1], currentLevel.sprites[sprite].spriteWidth);
        } else {
          circle(currentSpriteViewPos[0], currentSpriteViewPos[1], currentLevel.sprites[sprite].spriteWidth);
        }
      }
    }

    public int[] spriteViewPos(Sprite sprite) {
      int[] cameraPos = this.camera.getPos();
      return new int[]{sprite.xPos - cameraPos[0], sprite.yPos - cameraPos[1] };
    }
}
