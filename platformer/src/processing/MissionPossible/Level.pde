public class Level{
  boolean started;
  int score;
  int levelHeight;
  int levelWidth;
  int backgroundColour1;
  int backgroundColour2;
  int backgroundColour3;
  Sprite[] sprites;
  PlayerControlledSprite player;
  WeatherVariant weather;
  
 // Constructor - gets most of the level information from JSON file
   Level(String jsonFilePath){
     started = true;
     score = 0;
     
     JSONObject json = loadJSONObject(jsonFilePath);
     
     // Level height, width, weather and background colour
     levelHeight = json.getInt("height");
     levelWidth = json.getInt("width");
     backgroundColour1 = json.getInt("backgroundColour1");
     backgroundColour2  = json.getInt("backgroundColour2");
     backgroundColour3 = json.getInt("backgroundColour3");
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
     
     this.player = new PlayerControlledSprite(playerXPos, playerYPos, playerWidth, playerHeight, playerLayer, levelWidth, levelHeight);

     
     
     // Sprites
    JSONArray spriteData = (JSONArray) json.get("sprites");
    Sprite sprites[] = new Sprite[spriteData.size()];
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
      sprites[i] = new NonPlayerControlledSprite(xPos, yPos, spriteWidth, spriteHeight, spriteLayer, isEnemy, levelWidth, levelHeight);
    }
    this.sprites = sprites;
  }

  public int[] getLevelDims() {
    return new int[]{levelWidth, levelHeight};
  }
}
