boolean moveLeft = false;
boolean moveRight = false;
boolean moveUp = false;
boolean moveDown = false;
boolean jump = false;

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
        fill(color(255, 255, 255));
        rect(currentSpriteViewPos[0], currentSpriteViewPos[1], currentLevel.sprites[sprite].spriteWidth, currentLevel.sprites[sprite].spriteHeight);
      }
      fill(color(255, 0, 0));
      
      currentLevel.player.updatePosition(moveLeft, moveRight, moveUp, moveDown, jump, currentLevel.sprites);
      int[] playerPos = spriteViewPos(currentLevel.player);
      rect(playerPos[0], playerPos[1], currentLevel.player.spriteWidth, currentLevel.player.spriteHeight);
      //print(currentLevel.player.getXPos() - displayWidth / 2 + "\n");
      //print(currentLevel.player.getYPos() - displayHeight / 2+ "\n");
      this.camera.setPos(currentLevel.player.getXPos() - displayWidth / 2, currentLevel.player.getYPos() - displayHeight / 2);
    }

    public int[] spriteViewPos(Sprite sprite) {
      int[] cameraPos = this.camera.getPos();
      return new int[]{sprite.xPos - cameraPos[0], sprite.yPos - cameraPos[1] };
    }
}

void keyPressed() {
    if (key == 'd') {
        moveRight = true;
    } else if (key == 'a') {
        moveLeft = true;
    }
    if (key == ' ') {
      jump = true;
    }
}

void keyReleased() {
    if (key == 'd') {
        moveRight = false;
    } else if (key == 'a') {
        moveLeft = false;
    }

    if (key == ' ') {
      jump = false;
    }
}
