boolean moveLeft = false;
boolean moveRight = false;
boolean moveUp = false;
boolean moveDown = false;
boolean jump = false;

public class View {
    private final Camera camera;
    Level currentLevel;
    PImage backgroundImage;

    View(Level currentLevel) {
        int[] levelDims = currentLevel.getLevelDims();
        this.camera = new Camera(levelDims[0], levelDims[1]);
        this.currentLevel = currentLevel;
        this.backgroundImage = loadImage("Background-1.png");
        this.backgroundImage.resize(2300, 0);
    }
    
    public void displayView() {
      int[] cameraPos = this.camera.getPos();
      image(this.backgroundImage, (0 - cameraPos[0]) / 4, (0 - cameraPos[1]) / 4);
      for (int sprite = 0; sprite < currentLevel.sprites.length; sprite++) {
        int[] currentSpriteViewPos = spriteViewPos(currentLevel.sprites[sprite]);
        fill(color(255, 255, 255));
        rect(currentSpriteViewPos[0], currentSpriteViewPos[1], currentLevel.sprites[sprite].spriteWidth, currentLevel.sprites[sprite].spriteHeight);
      }
      fill(color(255, 0, 0));
      
      currentLevel.player.updatePosition(moveLeft, moveRight, moveUp, moveDown, jump, currentLevel.sprites);
      int[] playerPos = spriteViewPos(currentLevel.player);
      image(game.getCharacter(), playerPos[0], playerPos[1], currentLevel.player.spriteWidth, currentLevel.player.spriteHeight);
      this.camera.setPos(currentLevel.player.getXPos() - displayWidth / 2, currentLevel.player.getYPos() - displayHeight / 2);
    }

    public int[] spriteViewPos(Sprite sprite) {
      int[] cameraPos = this.camera.getPos();
      return new int[]{sprite.xPos - cameraPos[0], sprite.yPos - cameraPos[1] };
    }
    
}
