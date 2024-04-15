public class GameState {
  boolean started;
  boolean showTutorial;
  String playerNickname;
  int score;
  int lives;
  WeatherVariant weather;
  ModeVariant mode;
  SectionVariant section;
  CharacterVariant playerCharacter;
  int spaceshipParts;
  boolean partCollected=false;
  boolean landedPostCollection=false;
  String level;
  int level1Score;
  int level2Score;
  int level3Score;
  
  // Constructor
  GameState(){
    started = false;
    score = 0;
    lives = 3;
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
    lives = 3;
    spaceshipParts = 0;
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
         return "cat";
     }
  }
}
