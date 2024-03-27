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
