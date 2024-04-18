import java.io.File;
import java.util.HashMap;

public class Level{
  boolean started;
  long score;
  int levelHeight;
  int levelWidth;
  NonPlayerControlledSprite[] sprites;
  PlayerControlledSprite player;
  WeatherVariant weather;
  HashMap<String, PImage> imageMap;
  long startTime;
  long endTime;
  
 // Constructor - gets most of the level information from JSON file
   Level(String jsonFilePath){
     imageMap = new HashMap<>();
     started = true;
     score = 0;
     
     AudioPlayer bgmPlayer = minim.loadFile("sounds/game_bgm.mp3");
     bgmPlayer.loop();

     JSONObject json = loadJSONObject(jsonFilePath);
     
     File levelDir = new File(dataPath(jsonFilePath)).getParentFile();
     File[] files = levelDir.listFiles();

     if (files != null) {
       for (File file: files) {
         if (file.isFile() && (file.getName().toLowerCase().endsWith(".png") || file.getName().toLowerCase().endsWith(".jpg"))) {
           imageMap.put(file.getName(), loadImage(file.getAbsolutePath()));
         }
       }
     }
     
     // Level height, width, weather
     levelHeight = json.getInt("height");
     levelWidth = json.getInt("width");
     String weatherType = json.getString("weather");
     
     switch(weatherType){
       case "hot":
         weather=WeatherVariant.HOT;
         break;
       case "windy":
         weather=WeatherVariant.WINDY;
         break;
       case "icy":
         weather=WeatherVariant.ICY;
         break;
       case "foggy":
         weather=WeatherVariant.FOGGY;
         break;
       case "neutral":
         weather=WeatherVariant.NEUTRAL;
         break;
       default:
         weather=WeatherVariant.NEUTRAL;
     }
    
     
     // Get player sprite data from JSON file
     JSONObject playerData = (JSONObject) json.get("player");
     JSONObject playerPosition = playerData.getJSONObject("position");
     int playerXPos = playerPosition.getInt("xPos");
     int playerYPos = playerPosition.getInt("yPos");
     int playerWidth = playerData.getInt("spriteWidth");
     int playerHeight = playerData.getInt("spriteHeight");
     String playerImage = playerData.getString("spriteImage");
          
     this.player = new PlayerControlledSprite(playerXPos, playerYPos, playerWidth, playerHeight, levelWidth, levelHeight, playerImage);
     
     if (weather == WeatherVariant.ICY) {
       if (game.getModeVariant() == ModeVariant.DIFFICULT) {
         this.player.setXAcceleration(0.05f);
       } else {
         this.player.setXAcceleration(0.1f);
       }
     } else {
       this.player.setXAcceleration(0.2f);
     }
     
     if (weather == WeatherVariant.WINDY) {
       if (game.getModeVariant() == ModeVariant.DIFFICULT) {
          this.player.setWindFactor(1.8f);
       } else {
         this.player.setWindFactor(1.4f);
       }

     } else {
       this.player.setWindFactor(1.0f);
     }

     
     
     // Get other sprite data from JSON file
    JSONArray spriteData = (JSONArray) json.get("sprites");
    NonPlayerControlledSprite sprites[] = new NonPlayerControlledSprite[spriteData.size()];
    for (int i = 0; i < spriteData.size(); i++) {
      // Get each object in the array
      JSONObject sprite = spriteData.getJSONObject(i);
      // Get a position object
      JSONObject position = sprite.getJSONObject("position");
      // Get xPos, yPos from position
      int xPos = position.getInt("x");
      int yPos = position.getInt("y");
      // Get sprite width, height and layer from sprite
      int spriteWidth = sprite.getInt("spriteWidth");
      int spriteHeight = sprite.getInt("spriteHeight");
      boolean isEnemy = sprite.getBoolean("isEnemy");
      boolean isSpaceshipPart = sprite.getBoolean("isSpaceshipPart");
      String spriteImage = sprite.getString("spriteImage");
      sprites[i] = new NonPlayerControlledSprite(xPos, yPos, spriteWidth, spriteHeight, isEnemy, isSpaceshipPart, levelWidth, levelHeight, spriteImage, game.getModeVariant());
    }
    this.sprites = sprites;    
  }

  public int[] getLevelDims() {
    return new int[]{levelWidth, levelHeight};
  }
  
   public HashMap<String, PImage> getImageMap() {
    return this.imageMap;
  }
  
  public void restartLevel(){
    score = 0;
  }
  
  // Level score if lose all hearts
  public void calculateLevelScoreDead(){
    game.updateLevelScore(game.level, score);
  }
  
  // Level score if reach the end of level
  public void calculateLevelScoreAlive(){
    endTime = System.currentTimeMillis()/1000;
    score = score + (1000/(endTime - startTime))+(5*currentLevel.player.health);
    if(game.mode == ModeVariant.DIFFICULT){
      score *= 1.25;
    }
    game.updateLevelScore(game.level, score);
  }
  
  // If completing final level, go to game complete screen
  // Otherwise go to the scores screen
  public void endLevel(){
    calculateLevelScoreAlive();
    game.calculateGameScore();
    if(game.level.equals("level4")){
      game.section = SectionVariant.GAMECOMPLETE;
    }
    else{
      game.section = SectionVariant.SHOWSCORES;
    }
  }
}
