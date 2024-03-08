public class View {
    private final Camera camera;
    Level currentLevel;

    View(Level currentLevel) {
        this.camera = new Camera(displayWidth / 2, displayHeight / 2);
        this.currentLevel = currentLevel;
    }
    
    public void displayView() {
      for (int sprite = 0; sprite < currentLevel.sprites.length; sprite++) {

        if (currentLevel.sprites[sprite].shape.equals("square")) {

          square(currentLevel.sprites[sprite].xPos, currentLevel.sprites[sprite].yPos, currentLevel.sprites[sprite].spriteWidth);
        } else {
          circle(currentLevel.sprites[sprite].xPos, currentLevel.sprites[sprite].yPos, currentLevel.sprites[sprite].spriteWidth);
        }
      }
    }
}
