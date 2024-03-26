class BackToMain{

  String text;
  float itemWidth;
  float itemHeight;
  
  public BackToMain(){
    fill(255);
    textSize(45);
    this.text = "Back to Main Menu";
    float itemWidth = 750;
    float itemHeight = 160;
    float xPos = displayWidth/2 - itemWidth/2;
    float yPos = 9 * displayHeight/10;
    text(text, xPos, yPos, itemWidth, itemHeight);
  }
}
