class UIElement {
  UIElementVariant type;
  int xPos;
  int yPos;
  PImage asset;
  String textContent;
  int colour;
  int elementWidth;
  int elementHeight;

  public UIElement(UIElementVariant type, int xPos, int yPos, String textContent, int colour, PImage asset, int elementWidth, int elementHeight) {
    this.type = type;
    this.xPos = xPos;
    this.yPos = yPos;
    this.textContent = textContent;
    this.colour = colour;
    this.asset = asset;
    this.elementWidth = elementWidth;
    this.elementHeight = elementHeight;
  }
  
  public void drawElement() {
    fill(colour);

    switch (type) {
      case IMAGE:
        image(asset, xPos, yPos);
        break;
      case TEXT:
        textAlign(CENTER, CENTER);
        text(textContent, xPos, yPos);
        println("dingdong");
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
