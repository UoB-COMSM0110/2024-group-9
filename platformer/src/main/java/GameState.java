package main.java;

public class GameState {

    private boolean started;
    private boolean showTutorial;
    private String playerNickname;
    private int score;
    private int lives;
    private String weather;
    private int level;
    private ModeVariant mode; // uses ModeVariant enum
    private SectionVariant section; // For example 0 is start screen, 1 is choose character, 2 is enter nickname etc etc



    // Constructor method - likely will need to tweak the arguments
    public GameState(){
        started = true;
        score = 0;
        lives = 3; // TODO decide starting number of lives
        weather = "Neutral";
        section = SectionVariant.STARTSCREEN;
        // showTutorial, playerNickname, section and mode to be set using setter methods
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

    public ModeVariant getMode(){
        return mode;
    }

    public void setMode(ModeVariant newMode){
        mode = newMode;
    }

    public SectionVariant getSection(){
        return section;
    }

    public void setSection(SectionVariant newSection){
        section = newSection;
    }

    // Restart method
    public void restart(){
        score = 0;
        lives = 3;
        weather = "Neutral";
        level = 1;
        showTutorial = false;
        section = SectionVariant.STARTSCREEN;
    }

}
