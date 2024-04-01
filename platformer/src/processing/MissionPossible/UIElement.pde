class UIElement {
  UIElementVariant type;
  int xPos;
  int yPos;
  PImage asset;
  String textContent;
  int colour;
  int elementWidth;
  int elementHeight;
  int tintAmount;

  public UIElement(UIElementVariant type, int xPos, int yPos, String textContent, int colour, PImage asset, int elementWidth, int elementHeight, int tintAmount) {
    this.type = type;
    this.xPos = xPos;
    this.yPos = yPos;
    this.textContent = textContent;
    this.colour = colour;
    this.asset = asset;
    this.elementWidth = elementWidth;
    this.elementHeight = elementHeight;
    this.tintAmount = tintAmount;
  }
  
  public void drawElement() {
    fill(colour);

    switch (type) {
      case IMAGE:
        tint(255, tintAmount);
        image(asset, xPos, yPos, elementWidth, elementHeight);
        tint(255, 255);
        break;
      case TEXT:
        textAlign(LEFT, TOP);
        text(textContent, xPos, yPos);
        break;
      case RECT:
        rect(xPos, yPos, elementWidth, elementHeight);
        break;
    }
  }
  
  public void setTextContent(String textContent) {
    this.textContent = textContent;
  }
  
  public void setColour(int colour) {
    this.colour = colour;
  }
  
  public void setAsset(PImage asset) {
    this.asset = asset;
  }
}
