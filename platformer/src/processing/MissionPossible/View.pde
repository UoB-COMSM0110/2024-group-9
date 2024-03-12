boolean moveLeft = false;
boolean moveRight = false;
boolean moveUp = false;
boolean moveDown = false;

public class View {
    private final Camera camera;
    Level currentLevel;

    View(Level currentLevel) {
        this.camera = new Camera(0, 0);
        this.currentLevel = currentLevel;
    }
    
    public void displayView() {
      //if (key == 'w') {
      //  this.camera.setPos(this.camera.getXPos(), this.camera.getYPos() - 1);
      //} else if (key == 's') {
      //  this.camera.setPos(this.camera.getXPos(), this.camera.getYPos() + 1);
      //} else if (key == 'a') {
      //  this.camera.setPos(this.camera.getXPos() - 1, this.camera.getYPos());
      //} else if (key == 'd') {
      //  this.camera.setPos(this.camera.getXPos() + 1, this.camera.getYPos());
      //}
      for (int sprite = 0; sprite < currentLevel.sprites.length; sprite++) {
        int[] currentSpriteViewPos = spriteViewPos(currentLevel.sprites[sprite]);
        if (sprite < currentLevel.sprites.length -1) {
          fill(color(255, 255, 255));
          rect(currentSpriteViewPos[0], currentSpriteViewPos[1], currentLevel.sprites[sprite].spriteWidth, currentLevel.sprites[sprite].spriteHeight);
        } else {
          fill(color(255, 0, 0));
          print(frameRate + "\n");
          currentLevel.sprites[sprite].updatePosition(moveLeft, moveRight, moveUp, moveDown);
          rect(currentSpriteViewPos[0], currentSpriteViewPos[1], currentLevel.sprites[sprite].spriteWidth, currentLevel.sprites[sprite].spriteHeight);
          this.camera.setPos(currentLevel.sprites[sprite].getXPos() - displayWidth / 2, currentLevel.sprites[sprite].getYPos() - displayHeight / 2);
        }
        
      }
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

    if (key == 'w') {
        moveUp = true;
    } else if (key == 's') {
        moveDown = true;
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
