public class Level{
  boolean started;
  int score;
  int levelHeight;
  int levelWidth;
  int backgroundColour1;
  int backgroundColour2;
  int backgroundColour3;
  Sprite[] sprites; 
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
     
     if(weatherType == "hot"){
       weather = WeatherVariant.HOT;
     }
     else if(weatherType == "windy"){
       weather = WeatherVariant.WINDY;
     }
     else if(weatherType == "icy"){
       weather = WeatherVariant.ICY;
     }
     else if(weatherType == "foggy"){
       weather = WeatherVariant.FOGGY;
     }
     else{
       weather = WeatherVariant.NEUTRAL;
     }
     
     
     // Sprites
    JSONArray spriteData = (JSONArray) json.get("sprites");
    Sprite sprites[] = new Sprite[spriteData.size() + 1];
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
      // Put objects in array
      sprites[i] = new NonPlayerControlledSprite(xPos, yPos, spriteWidth, spriteHeight, spriteLayer, isEnemy);
    }
    sprites[9] = new PlayerControlledSprite(0, 1070, 30, 30, 1);
    this.sprites = sprites;
  }
}
