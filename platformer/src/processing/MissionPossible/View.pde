boolean moveLeft = false;
boolean moveRight = false;
boolean moveUp = false;
boolean moveDown = false;
boolean jump = false;
ArrayList<FallingSnowflake> snowflakes;

public class View {
    private final Camera camera;
    Level currentLevel;
    PImage backgroundImage;
    UserInterface userInterface;
    String[] tutorialInstructions = {
      "Welcome to the Mission Possible tutorial!\n\nTo move right, press "+KeyEvent.getKeyText(settings.rightKey)+".",
      "To move left, press "+KeyEvent.getKeyText(settings.leftKey)+".",
      "To jump, press "+KeyEvent.getKeyText(settings.jumpKey)+"\nPress twice to double jump.",
      "To dash in the direction you're facing, press "+KeyEvent.getKeyText(settings.dashKey)+".",
      "You can change these key commands in the game settings menu.\n\nClick anywhere to exit to the main menu."
    };
    int currentInstructionIndex = 0;
    boolean rightCompleted;
    boolean leftCompleted;
    boolean jumpCompleted;
    boolean dashCompleted;
    int scale = 1;
    ArrayList<FogElement> fogElements;
    ArrayList<Wind> windElements;

    View(Level currentLevel) {
        int[] levelDims = currentLevel.getLevelDims();

        this.camera = new Camera(levelDims[0], levelDims[1]);
        this.currentLevel = currentLevel;
        userInterface = new UserInterface();
        if (currentLevel.weather == WeatherVariant.ICY) {
          snowflakes = new ArrayList<FallingSnowflake>();
          for (int i = 0; i < 1000; i++) {
            snowflakes.add(new FallingSnowflake(currentLevel.levelWidth, currentLevel.levelHeight));
          }
        }
        
        if (currentLevel.weather == WeatherVariant.FOGGY) {
          this.fogElements = new ArrayList<FogElement>();
          for (int b = 0; b < 1000; b++) {
            fogElements.add(new FogElement(currentLevel.levelWidth, currentLevel.levelHeight, 0.005, 0.1));
          }
        }
        this.backgroundImage = currentLevel.imageMap.get("background.png");
        this.backgroundImage.resize(levelDims[0], levelDims[1]);
        
        if (currentLevel.weather == WeatherVariant.WINDY) {
          this.windElements = new ArrayList<Wind>();
          for (int i = 0; i < 1000; i++) {
            windElements.add(new Wind(currentLevel.levelWidth, currentLevel.levelHeight));
          }
        }
    }
    
    public void displayView() {
      int[] cameraPos = this.camera.getPos();
      image(this.backgroundImage, (0 - cameraPos[0]) / 4, (0 - cameraPos[1]) / 4);
      for (int sprite = 0; sprite < currentLevel.sprites.length; sprite++) {
        int[] currentSpriteViewPos = spriteViewPos(currentLevel.sprites[sprite].xPos, currentLevel.sprites[sprite].yPos);
        fill(color(255, 255, 255));
        image(currentLevel.imageMap.get(currentLevel.sprites[sprite].image), currentSpriteViewPos[0], currentSpriteViewPos[1], currentLevel.sprites[sprite].spriteWidth, currentLevel.sprites[sprite].spriteHeight);
        //change the position of enemy
        if(currentLevel.sprites[sprite].isEnemy || currentLevel.sprites[sprite].isSpaceshipPart){
          currentLevel.sprites[sprite].updatePosition(currentLevel.sprites[sprite - 1].getXPos(), currentLevel.sprites[sprite - 1].getXPos() + currentLevel.sprites[sprite - 1].getSpriteWidth() - currentLevel.sprites[sprite].getSpriteWidth());
        }
      }
      fill(color(255, 0, 0));
      currentLevel.player.updatePosition(moveLeft, moveRight, moveUp, moveDown, jump, currentLevel.sprites);
      int[] playerPos = spriteViewPos(currentLevel.player.xPos, currentLevel.player.yPos);
      pushMatrix();
      if (!currentLevel.player.getFaceToRight()) {
        this.scale = -1;
      }
      scale(this.scale, 1);
      image(currentLevel.player.getNextFrame(), playerPos[0] * this.scale, playerPos[1], currentLevel.player.spriteWidth * this.scale, currentLevel.player.spriteHeight);
      this.scale = 1;
      popMatrix();
      this.camera.setPos(currentLevel.player.getXPos() - displayWidth / 2, currentLevel.player.getYPos() - displayHeight / 2);

      UIElement health0 = userInterface.getElement("health0");
      UIElement health1 = userInterface.getElement("health1");
      UIElement health2 = userInterface.getElement("health2");
      if(currentLevel.player.health == 2){
        health2.setAsset(userInterface.getAsset("heart-empty.png"));
      }
      if(currentLevel.player.health == 1){
        health1.setAsset(userInterface.getAsset("heart-empty.png"));
      }
      if(currentLevel.player.health == 0){
        health0.setAsset(userInterface.getAsset("heart-empty.png"));
        if(game.mode == ModeVariant.EASY){
          currentLevel.calculateLevelScoreDead();
          currentLevel.restartLevel();
          game.section = SectionVariant.RESTARTLEVEL;
        }
        else{
          currentLevel.calculateLevelScoreDead();
          game.calculateGameScore();
          game.section = SectionVariant.GAMEOVER;
        }
      }
      userInterface.drawUI();
      if(game.section == SectionVariant.TUTORIAL){
        runTutorial();
      }
      if (currentLevel.weather == WeatherVariant.FOGGY) {
        for (FogElement fogElement : fogElements) {
          fogElement.update();
          fogElement.display(spriteViewPos(fogElement.getX(), fogElement.getY()));
        }
      }
      if (currentLevel.weather == WeatherVariant.ICY) {
        for (FallingSnowflake flake : snowflakes) {
          flake.update();
          flake.display(spriteViewPos(flake.getX(), flake.getY()));
        }
      }
      if (currentLevel.weather == WeatherVariant.WINDY) {
        for (Wind windElement : windElements) {
          windElement.update();
          windElement.display(spriteViewPos(windElement.getX(), windElement.getY()));
        }
      }
    }

    public int[] spriteViewPos(int xPos, int yPos) {
      int[] cameraPos = this.camera.getPos();
      return new int[]{xPos - cameraPos[0], yPos - cameraPos[1] };
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
