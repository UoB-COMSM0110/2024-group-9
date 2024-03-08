public class GameState {
  boolean started;
  boolean characterChosen;
  boolean nameSelected;
  boolean showTutorial;
  String playerNickname;
  int score;
  int lives;
  ModeVariant mode;
  SectionVariant section;
  CharacterVariant playerCharacter;
  
  // Constructor
  GameState(){
    started = false;
    score = 0;
    lives = 3;
    section = SectionVariant.STARTSCREEN;
    playerNickname = "";
    // Initial showTutorial, playerNickname, playerCharacter, section and mode values to be set once player has started entering information
  }
  
  // Restart
  void restart(){
    score = 0;
    lives = 3;
    showTutorial = false;
    section = SectionVariant.GAMELEVELS;
  }
}
