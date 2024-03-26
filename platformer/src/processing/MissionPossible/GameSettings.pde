public class GameSettings{
    char leftKey;
    char rightKey;
    char jumpKey;
    char dashKey;
    
    
  public GameSettings(){
    leftKey = 'a';
    rightKey = 'd';
    jumpKey = ' ';
    dashKey = 17;
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
