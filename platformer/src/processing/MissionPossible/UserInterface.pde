import java.util.HashMap;

class UserInterface{
  GameState gamestate;
  HashMap<String, UIElement> uiElements;
  
  public UserInterface() {
    uiElements = new HashMap<>();
    uiElements.put("health", new UIElement(UIElementVariant.TEXT, displayWidth / 13, displayHeight / 20, "100!", 255, null, 0, 0));

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
