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
  
  // Constructor
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
    // Initial showTutorial, playerNickname, playerCharacter, section and mode values to be set once player has started entering information
  }
  
  // Restart
  void restart(){
    score = 0;
    spaceshipPieces = 0;
    playerNickname = "";
    level1Score = 0;
    level2Score = 0;
    level3Score = 0;
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
    score = level1Score + level2Score +level3Score;
    if(mode == ModeVariant.DIFFICULT){
      score *= 1.25;
    }
  }
  
  public void updateLevelScore(String levelNo, long levelScore){
    if(levelNo == "level1"){
      level1Score = levelScore;
    }
    else if(levelNo == "level2"){
      level2Score = levelScore;
    }
    else if(levelNo == "level3"){
      level3Score = levelScore;
    }
  }
}
