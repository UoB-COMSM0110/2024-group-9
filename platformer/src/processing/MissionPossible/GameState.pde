public class GameState {
  boolean started;
  boolean showTutorial;
  String playerNickname;
  long score;
  WeatherVariant weather;
  ModeVariant mode;
  SectionVariant section;
  CharacterVariant playerCharacter;
  int spaceshipPieces;
  String level;
  long level1Score;
  long level2Score;
  long level3Score;
  long level4Score;
  boolean inTransition;
  boolean[] spaceshipPartsCollected;
  
  // Constructor
  // Initial showTutorial, playerNickname, playerCharacter, section and mode values to be set once player has started entering information
  GameState(){
    started = false;
    score = 0;
    weather = WeatherVariant.NEUTRAL;
    section = SectionVariant.STARTSCREEN;
    playerNickname = "";
    spaceshipPieces = 0;
    level1Score = 0;
    level2Score = 0;
    level3Score = 0;
    level4Score = 0;
    spaceshipPartsCollected = new boolean[4];
  }
  
  public void collectPart(int index){
    if(index>=0 && index< spaceshipPartsCollected.length){
      spaceshipPartsCollected[index]=true;
    }
  }
  
  // Restart
  void restart(){
    score = 0;
    spaceshipPieces = 0;
    playerNickname = "";
    level1Score = 0;
    level2Score = 0;
    level3Score = 0;
    level4Score = 0;
  }
  
 String getCharacter(){
    switch(playerCharacter){
       case SPACEMAN:
         return "spaceman";
       case COWBOY:
         return "cowboy";
       case FOX:
         return "fox";
       case CAT:
         return "cat";
       case SKELETON:
         return "skeleton";
       case WOLF:
         return "wolf";
       default:
         return "fox";
     }
  }
  
  public void calculateGameScore(){
    score = level1Score + level2Score +level3Score + level4Score;
  }
  
  public void updateLevelScore(String levelNo, long levelScore){
    if(levelNo.equals("level1")){
      level1Score = levelScore;
    }
    else if(levelNo.equals("level2")){
      level2Score = levelScore;
    }
    else if(levelNo.equals("level3")){
      level3Score = levelScore;
    }
    else if (levelNo.equals("level4")){
      level4Score = levelScore;
    }
  }
  
  public long getScore() {
    return score;
  }
  
  public void increaseSpaceshipPieces(){
    spaceshipPieces++;
  }
}
