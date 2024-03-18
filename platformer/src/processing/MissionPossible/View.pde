boolean moveLeft = false;
boolean moveRight = false;
boolean moveUp = false;
boolean moveDown = false;

public class View {
    private final Camera camera;
    Level currentLevel;

    View(Level currentLevel) {
        int[] levelDims = currentLevel.getLevelDims();
        this.camera = new Camera(levelDims[0], levelDims[1]);
        this.currentLevel = currentLevel;
    }
    
    public void displayView() {
      for (int sprite = 0; sprite < currentLevel.sprites.length; sprite++) {
        int[] currentSpriteViewPos = spriteViewPos(currentLevel.sprites[sprite]);
        if (sprite < currentLevel.sprites.length -1) {
          fill(color(255, 255, 255));
          rect(currentSpriteViewPos[0], currentSpriteViewPos[1], currentLevel.sprites[sprite].spriteWidth, currentLevel.sprites[sprite].spriteHeight);
        } else {
          fill(color(255, 0, 0));
          currentLevel.sprites[sprite].updatePosition(moveLeft, moveRight, moveUp, moveDown);
          rect(currentSpriteViewPos[0], currentSpriteViewPos[1], currentLevel.sprites[sprite].spriteWidth, currentLevel.sprites[sprite].spriteHeight);
          print(currentLevel.sprites[sprite].getXPos() - displayWidth / 2 + "\n");
          print(currentLevel.sprites[sprite].getYPos() - displayHeight / 2+ "\n");
          this.camera.setPos(currentLevel.sprites[sprite].getXPos() - displayWidth / 2, currentLevel.sprites[sprite].getYPos() - displayHeight / 2);
        }
        
      }
    }

    public int[] spriteViewPos(Sprite sprite) {
      int[] cameraPos = this.camera.getPos();
      return new int[]{sprite.xPos - cameraPos[0], sprite.yPos - cameraPos[1] };
    }
}

void keyReleased() {
    if (key == 'd') {
        moveRight = false;
    } else if (key == 'a') {
        moveLeft = false;
    }

    if (key == 'w') {
        moveUp = false;
    } else if (key == 's') {
        moveDown = false;
    }
}
