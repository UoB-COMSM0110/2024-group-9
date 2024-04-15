import java.io.File;
import java.util.HashMap;

public class Level{
  boolean started;
  int score;
  int levelHeight;
  int levelWidth;
  NonPlayerControlledSprite[] sprites;
  PlayerControlledSprite player;
  WeatherVariant weather;
  HashMap<String, PImage> imageMap;
  PVector playerCentered;
  float blackoutTransitionRadius;
  boolean transitioning = false;
  
 // Constructor - gets most of the level information from JSON file
   Level(String jsonFilePath){
     imageMap = new HashMap<>();
     started = true;
     score = 0;

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
     
     // Player sprite
     JSONObject playerData = (JSONObject) json.get("player");
     JSONObject playerPosition = playerData.getJSONObject("position");
     int playerXPos = playerPosition.getInt("xPos");
     int playerYPos = playerPosition.getInt("yPos");
     int playerWidth = playerData.getInt("spriteWidth");
     int playerHeight = playerData.getInt("spriteHeight");
     int playerLayer = playerData.getInt("layer");
     String playerImage = playerData.getString("spriteImage");
          
     this.player = new PlayerControlledSprite(playerXPos, playerYPos, playerWidth, playerHeight, playerLayer, levelWidth, levelHeight, playerImage);

     
     
     // Sprites
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
      int spriteLayer = sprite.getInt("layer");
      boolean isEnemy = sprite.getBoolean("isEnemy");
      boolean isCollectiblePart = sprite.getBoolean("isCollectiblePart");
      String spriteImage = sprite.getString("spriteImage");
      sprites[i] = new NonPlayerControlledSprite(xPos, yPos, spriteWidth, spriteHeight, spriteLayer, isEnemy, isCollectiblePart, levelWidth, levelHeight, spriteImage);
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
    game.lives = 3;
  }
  
  public void updateLevel(){
    if(game.spaceshipParts>0 && !game.partCollected){
      game.partCollected=true;
    }
    if(game.partCollected && !game.landedPostCollection){
      if(player.landed){
        game.landedPostCollection=true;
        initiateTransition();
      }
    }
  }
  
  private void initiateTransition(){
    transitioning = true;
    playerCentered = new PVector(player.getXPos()+player.spriteWidth/2, player.getYPos() + player.spriteHeight/2);
    float screenDimsMax = max(displayWidth, displayHeight);
    blackoutTransitionRadius = sqrt(sq(screenDimsMax)+sq(screenDimsMax))/2;
  }
  
  public void loadNextLevel(){
    //NEED A LEVEL IDENTIFIER AND CORRESPONDING TRACKER (for the nextLevelID string below)
    //this is just skeleton-ish for now
    if(nextLevelID!= null){ //ensure a next level exists
      this.currentLevel=new Level(nextLevelID); //will reinitalise the level with the new data (map, sprites, parts) fpr it
      game.section=SectionVariant.GAMELEVELS;
      this.currentLevel.player.resetState(); //method to reset the position to the starting point of the next level (and lives unless we want to keep the lives over from one level to the next which i htink is how it should be)
    } else {
      game.section=SectionVariant.GAMEOVER;
    }
}
