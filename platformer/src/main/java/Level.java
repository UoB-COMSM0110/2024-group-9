package main.java;

import processing.core.PApplet;
import processing.data.JSONArray;
import processing.data.JSONObject;


public class Level() {
    private String domain;
    private final PApplet parent;
    private boolean started;
    private int score;

    // Set overall space available for the level
    private int height;
    private int width;
    private int backgroundColour1;
    private int backgroundColour2;
    private int backgroundColour3;

    // Constructor method
    public Level(String jsonFilePath, PApplet parent) {
        this.parent = parent;
        started = true;
        score = 0;
        // Load data from JSON file
        JSONObject json = parent.loadJSONObject(jsonFilePath);

        // Level width, height and background colour
        height = json.getInt("height");
        width = json.getInt("width");
        backgroundColour1 = json.getInt("backgroundColour1");
        backgroundColour2  = json.getInt("backgroundColour2");
        backgroundColour3 = json.getInt("backgroundColour3");

        // Sprites
        JSONArray spriteData = (JSONArray) json.get("sprites");
        Sprite sprites[] = new Sprite[spriteData.size()];

        for (int i = 0; i < spriteData.size(); i++) {
            // Get each object in the array
            JSONObject sprite = spriteData.getJSONObject(i);
            // Get a position object
            JSONObject position = sprite.getJSONObject("position");
            // Get xPos, yPos from position
            int xPos = position.getInt("xPos");
            int yPos = position.getInt("yPos");
            // Get sprite width, height and layer from sprite
            int spriteWidth = sprite.getInt("spriteWidth");
            int spriteHeight = sprite.getInt("spriteHeight");
            int spriteLayer = sprite.getInt("layer");

            // Put objects in array
            sprites[i] = new Sprite(xPos, yPos, spriteWidth, spriteHeight, spriteLayer);
        }

    }

    // Getter and setter methods
    public boolean getStarted(){
        return started;
    }

    public void setStarted(boolean levelStarted){
        started = levelStarted;
    }

    public int getScore(){
        return score;
    }

    public void setScore(int newScore){
        score = newScore;
    }

    public int getHeight(){
        return height;
    }

    public void setHeight(int newHeight){
        height = newHeight;
    }

    public int getWidth(){
        return width;
    }

    public void setWidth(int newWidth){
        width = newWidth;
    }

}
