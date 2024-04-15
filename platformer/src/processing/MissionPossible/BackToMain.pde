class BackToMain{

  String text;
  float itemWidth;
  float itemHeight;
  
  public BackToMain(){
  // Display menu option to take player back to main menu
  fill(255);
  hoverTextSize(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 9*displayHeight/10, (9*displayHeight/10)+menuItemHeight);
  this.text = "Back to Main Menu";
  float xPos = displayWidth/2 - menuItemWidth/2;
  float yPos = 9 * displayHeight/10;
  text(text, xPos, yPos, menuItemWidth, menuItemHeight);
  }
}
