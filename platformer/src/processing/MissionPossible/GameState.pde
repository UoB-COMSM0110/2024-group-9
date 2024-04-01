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
  int spaceshipPieces;
  
  // Constructor
  GameState(){
    started = false;
    score = 0;
    lives = 3;
    weather = WeatherVariant.NEUTRAL;
    section = SectionVariant.STARTSCREEN;
    playerNickname = "";
    spaceshipPieces = 0;
    // Initial showTutorial, playerNickname, playerCharacter, section and mode values to be set once player has started entering information
  }
  
  // Restart
  void restart(){
    score = 0;
    lives = 3;
    weather = WeatherVariant.NEUTRAL;
    showTutorial = false;
    section = SectionVariant.GAMELEVELS;
    spaceshipPieces = 0;
  }
  
 PImage getCharacter(){
    switch(playerCharacter){
       case SPACEMAN:
         return spaceman;
       case COWBOY:
         return cowboy;
       case RHINO:
         return rhino;
       case CAT:
         return cat;
       case SKELETON:
         return skeleton;
       case DOG:
         return dog;
       default:
         return spaceman;
     }
  }
}
