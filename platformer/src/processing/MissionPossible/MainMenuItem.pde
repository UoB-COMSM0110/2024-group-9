class MainMenuItem{

  String text;
  
  public MainMenuItem(String menuText, float yPos){
    this.text = menuText;
    float xPos = displayWidth/2 - menuItemWidth/2;
    text(menuText, xPos, yPos, menuItemWidth, menuItemHeight);
  }
}
