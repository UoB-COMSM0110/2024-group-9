package main.java;

public class GameState {

    private boolean started;
    // TODO add restart - not sure of type
    private boolean showTutorial;
    private String playerNickname;
    private int score;
    private int lives;
    private String weather;
    private int level;

    // Constructor method - likely will need to tweak the arguments
    public GameState(String nickname, boolean tutorial){
        started = true;
        showTutorial = tutorial;
        playerNickname = nickname;
        score = 0;
        lives = 3; // TODO decide starting number of lives
        weather = "Neutral";
    }

    // Getter and setter methods - not sure if setStarted and setShowTutorial are necessary?
    public boolean getStarted(){
        return started;
    }

    public void setStarted(boolean start){
        started = start;
    }

    public boolean getShowTutorial(){
        return showTutorial;
    }

    public void setShowTutorial(boolean tutorial){
        showTutorial = tutorial;
    }

    public String getPlayerNickname(){
        return playerNickname;
    }

    public int getScore(){
        return score;
    }

    public void setScore(int newScore){
        score = newScore;
    }

    public int getLives(){
        return lives;
    }

    public void setLives(int newLives){
        lives = newLives;
    }

    public String getWeather(){
        return weather;
    }

    public void setWeather(String newWeather){
        weather = newWeather;
    }

    public int getLevel(){
        return level;
    }

    public void setLevel(int newLevel){
        level = newLevel;
    }

}
