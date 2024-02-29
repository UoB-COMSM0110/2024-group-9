package main.java;

public class Level {
    private boolean started;
    private int score;

    // Set overall space available for the level
    private int height;
    private int width;

    // Need some way of storing the map for the level - location of different sprites
    // ArrayLists of Sprites? Would need Sprites to have co-ordinates within the level space.
    // When a level is instantiated an ArrayList of Sprites is generated for that level.
    // How to access the sprites to change their attributes?

    // private ArrayList<Sprite> sprites;
    
    private String backgroundColour; // Probably change this depending on how drawing is done

    // Constructor method
    public Level(){
        started = true;
        score = 0;
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
