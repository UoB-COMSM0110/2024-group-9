public class GameSettings{
    int leftKey;
    int rightKey;
    int jumpKey;
    int dashKey;
    
    
  public GameSettings(){
    leftKey = 'A';
    rightKey = 'D';
    jumpKey = ' ';
    dashKey = CONTROL;
  }

  public void setLeftKey(char lKey){
    leftKey = lKey;
  }
  
  public void setRightKey(char rKey){
    rightKey = rKey;
  }
  
  public void setJumpKey(char jKey){
    jumpKey = jKey;
  }
  
  public void setDashKey(char dKey){
    dashKey = dKey;
  }

}
