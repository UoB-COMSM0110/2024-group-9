class MainMenuItem{

  String text;
  float itemWidth;
  float itemHeight;
  
  public MainMenuItem(String menuText, float yPos){
    fill(255);
    textSize(45);
    this.text = menuText;
    float itemWidth = 750;
    float itemHeight = 160;
    float xPos = displayWidth/2 - itemWidth/2;
    text(menuText, xPos, yPos, itemWidth, itemHeight);
  }
}
