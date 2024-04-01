boolean moveLeft = false;
boolean moveRight = false;
boolean moveUp = false;
boolean moveDown = false;
boolean jump = false;


public class View {
    private final Camera camera;
    Level currentLevel;
    PImage backgroundImage;
    String[] tutorialInstructions = {
      "Welcome to the Mission Possible tutorial!\n\nTo move right, press "+KeyEvent.getKeyText(settings.rightKey)+".",
      "To move left, press "+KeyEvent.getKeyText(settings.leftKey)+".",
      "To jump, press "+KeyEvent.getKeyText(settings.jumpKey)+"\nYou can use this tutorial to practice jumping between platforms.",
      "To dash, move left or right and press "+KeyEvent.getKeyText(settings.dashKey)+".",
      "You can change these key commands in the game settings menu.\n\nPress E to exit to the main menu."
    };
    int currentInstructionIndex = 0;
    boolean rightCompleted;
    boolean leftCompleted;
    boolean jumpCompleted;
    boolean dashCompleted;

    View(Level currentLevel) {
        int[] levelDims = currentLevel.getLevelDims();
        this.camera = new Camera(levelDims[0], levelDims[1]);
        this.currentLevel = currentLevel;
        if(game.section != SectionVariant.TUTORIAL){
          this.backgroundImage = loadImage("Background-1.png");
          this.backgroundImage.resize(2300, 0);
        }
    }
    
    public void displayView() {
      int[] cameraPos = this.camera.getPos();
      if(game.section != SectionVariant.TUTORIAL){
        image(this.backgroundImage, (0 - cameraPos[0]) / 4, (0 - cameraPos[1]) / 4);
      }
      for (int sprite = 0; sprite < currentLevel.sprites.length; sprite++) {
        int[] currentSpriteViewPos = spriteViewPos(currentLevel.sprites[sprite]);
        fill(color(255, 255, 255));
        image(currentLevel.imageMap.get("platform.png"), currentSpriteViewPos[0], currentSpriteViewPos[1], currentLevel.sprites[sprite].spriteWidth, currentLevel.sprites[sprite].spriteHeight);
      }
      fill(color(255, 0, 0));
      
      currentLevel.player.updatePosition(moveLeft, moveRight, moveUp, moveDown, jump, currentLevel.sprites);
      int[] playerPos = spriteViewPos(currentLevel.player);
      image(game.getCharacter(), playerPos[0], playerPos[1], currentLevel.player.spriteWidth, currentLevel.player.spriteHeight);
      this.camera.setPos(currentLevel.player.getXPos() - displayWidth / 2, currentLevel.player.getYPos() - displayHeight / 2);
      if(game.section == SectionVariant.TUTORIAL){
        runTutorial();
      }
    }

    public int[] spriteViewPos(Sprite sprite) {
      int[] cameraPos = this.camera.getPos();
      return new int[]{sprite.xPos - cameraPos[0], sprite.yPos - cameraPos[1] };
    }
    
    public void runTutorial(){
      rightCompleted = false;
      leftCompleted = false;
      jumpCompleted = false;
      dashCompleted = false;
      textAlign(CENTER, CENTER);
      fill(255);
      textSize(notHoveredSize);
      text(tutorialInstructions[currentInstructionIndex], displayWidth/2, displayHeight/4, menuItemWidth);
  }
}
