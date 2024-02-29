package main.java;

public class Level {
    private boolean started;
    private int score;

    // Need some way of storing the map for the level - location of different sprites

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

}
