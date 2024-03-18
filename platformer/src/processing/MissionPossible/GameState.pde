public class GameState {
  boolean started;
  boolean characterChosen;
  boolean nameSelected;
  boolean tutorialChosen;
  boolean showTutorial;
  String playerNickname;
  int score;
  int lives;
  WeatherVariant weather;
  ModeVariant mode;
  SectionVariant section;
  CharacterVariant playerCharacter;
  
  // Constructor
  GameState(){
    started = false;
    score = 0;
    lives = 3;
    weather = WeatherVariant.NEUTRAL;
    section = SectionVariant.STARTSCREEN;
    playerNickname = "";
    // Initial showTutorial, playerNickname, playerCharacter, section and mode values to be set once player has started entering information
  }
  
  // Restart
  void restart(){
    score = 0;
    lives = 3;
    weather = WeatherVariant.NEUTRAL;
    showTutorial = false;
    section = SectionVariant.GAMELEVELS;
  }
}
