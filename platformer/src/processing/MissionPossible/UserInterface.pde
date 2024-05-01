import java.util.HashMap;

class UserInterface{
  GameState gamestate;
  HashMap<String, UIElement> uiElements;
  HashMap<String, PImage> uiAssets;
  
  public UserInterface() {
    // Constructor to load UI assets and instanciate all UI elements
    uiElements = new HashMap<>();
    uiAssets = new HashMap<>();
    uiAssets.put("heart.png", loadImage(dataPath("heart.png")));
    uiAssets.put("heart-empty.png", loadImage(dataPath("heart-empty.png")));
    uiAssets.put("spaceship_part1.png", loadImage(dataPath("level1" + File.separator + "spaceship_part1.png")));
    uiAssets.put("spaceship_part2.png", loadImage(dataPath("level2" + File.separator + "spaceship_part2.png")));
    uiAssets.put("spaceship_part3.png", loadImage(dataPath("level3" + File.separator + "spaceship_part3.png")));
    uiAssets.put("spaceship_part4.png", loadImage(dataPath("level4" + File.separator + "spaceship_part4.png")));
    for (int i = 0; i < 3; i++) {
      uiElements.put("health" + String.valueOf(i), new UIElement(UIElementVariant.IMAGE, displayWidth / 30 + i * displayWidth / 35, displayHeight / 20, "", 255, uiAssets.get("heart.png"), displayHeight / 20, displayHeight / 20, 255));
    }
    uiElements.put("part1", new UIElement(UIElementVariant.IMAGE, 9 * displayWidth / 13, displayHeight / 20, "", 255, uiAssets.get("spaceship_part1.png"), displayHeight / 20, displayHeight / 20, 100));
    uiElements.put("part2", new UIElement(UIElementVariant.IMAGE, 9 * displayWidth / 13 + 1 * displayWidth / 35, displayHeight / 20, "", 255, uiAssets.get("spaceship_part2.png"), displayHeight / 20, displayHeight / 20, 100));
    uiElements.put("part3", new UIElement(UIElementVariant.IMAGE, 9 * displayWidth / 13 + 2 * displayWidth / 35, displayHeight / 20, "", 255, uiAssets.get("spaceship_part3.png"), displayHeight / 20, displayHeight / 20, 100));
    uiElements.put("part4", new UIElement(UIElementVariant.IMAGE, 9 * displayWidth / 13 + 3 * displayWidth / 35, displayHeight / 20, "", 255, uiAssets.get("spaceship_part4.png"), displayHeight / 20, displayHeight / 20, 100));
    for(int i = 1; i <= game.spaceshipPieces; i++){
      getElement("part"+Integer.toString(i)).setTintAmount(255);
    }
  }
  
  public void drawUI() {
    uiElements.forEach((key, value) -> {
            value.drawElement();
        });
  }
  
  public UIElement getElement(String key) {
    return uiElements.get(key);
  }
  
  public PImage getAsset(String key) {
    return uiAssets.get(key);
  }
  
}
