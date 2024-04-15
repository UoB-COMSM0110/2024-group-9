public class GameSettings{
    int leftKey;
    int rightKey;
    int jumpKey;
    int dashKey;
    
  // Set initial controls
  public GameSettings(){
    leftKey = 'A';
    rightKey = 'D';
    jumpKey = ' ';
    dashKey = CONTROL;
  }

  // Methods to set keybinds to player's choices
  public void setLeftKey(int lKey){
    leftKey = lKey;
  }
  
  public void setRightKey(int rKey){
    rightKey = rKey;
  }
  
  public void setJumpKey(int jKey){
    jumpKey = jKey;
  }
  
  public void setDashKey(int dKey){
    dashKey = dKey;
  }

}
