import java.util.HashMap;

class UserInterface{
  GameState gamestate;
  HashMap<String, UIElement> uiElements;
  
  public UserInterface() {
    uiElements = new HashMap<>();
    uiElements.put("fps", new UIElement(UIElementVariant.TEXT, 11 * displayWidth / 13, displayHeight / 20, "100!", 255, null, 0, 0, 255));
    for (int i = 0; i < 3; i++) {
      uiElements.put("health" + String.valueOf(i), new UIElement(UIElementVariant.IMAGE, displayWidth / 30 + i * displayWidth / 35, displayHeight / 20, "", 255, loadImage(dataPath("heart.png")), displayHeight / 20, displayHeight / 20, 255));
    }
    uiElements.put("part1", new UIElement(UIElementVariant.IMAGE, 9 * displayWidth / 13, displayHeight / 20, "", 255, loadImage(dataPath("level1" + File.separator + "spaceship_part1.png")), displayHeight / 20, displayHeight / 20, 128));
    uiElements.put("part2", new UIElement(UIElementVariant.IMAGE, 9 * displayWidth / 13 + 1 * displayWidth / 35, displayHeight / 20, "", 255, loadImage(dataPath("level2" + File.separator + "spaceship_part2.png")), displayHeight / 20, displayHeight / 20, 128));
    uiElements.put("part3", new UIElement(UIElementVariant.IMAGE, 9 * displayWidth / 13 + 2 * displayWidth / 35, displayHeight / 20, "", 255, loadImage(dataPath("level3" + File.separator + "spaceship_part3.png")), displayHeight / 20, displayHeight / 20, 128));
  }
  
  public void drawUI() {
    uiElements.forEach((key, value) -> {
            value.drawElement();
        });
  }
  
  public UIElement getElement(String key) {
    return uiElements.get(key);
  }
  
  
}
