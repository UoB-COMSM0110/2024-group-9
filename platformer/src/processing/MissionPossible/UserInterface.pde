import java.util.HashMap;

class UserInterface{
  GameState gamestate;
  HashMap<String, UIElement> uiElements;
  
  public UserInterface() {
    uiElements = new HashMap<>();
    uiElements.put("health", new UIElement(UIElementVariant.TEXT, displayWidth / 13, displayHeight / 20, "100!", 255, null, 0, 0, 255));
    uiElements.put("part1", new UIElement(UIElementVariant.IMAGE, 10 * displayWidth / 13, displayHeight / 20, "", 255, loadImage(dataPath("spaceship_part1.png")), 0, 0, 128));
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
