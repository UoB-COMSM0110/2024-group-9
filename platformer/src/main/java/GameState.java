package main.java;

public class GameState {

    private boolean started;
    private boolean showTutorial;
    private String playerNickname;
    private int score;
    private int lives;
    private WeatherVariant weather;
    private ModeVariant mode; // uses ModeVariant enum
    private SectionVariant section; // Uses SectionVariant enum

    // Constructor method
    public GameState(){
        started = true;
        score = 0;
        lives = 3; // TODO decide starting number of lives
        weather = WeatherVariant.NEUTRAL;
        section = SectionVariant.STARTSCREEN;
        // Initial showTutorial, playerNickname, section and mode to be set using setter methods
    }

    // Getter and setter methods
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

    public void setPlayerNickname(String newPlayerNickname){
        playerNickname = newPlayerNickname;
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

    public WeatherVariant getWeather(){
        return weather;
    }

    public void setWeather(WeatherVariant newWeather){
        weather = newWeather;
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

    // Restart method - not sure if we need to reset anything else here?
    public void restart(){
        score = 0;
        lives = 3;
        weather = WeatherVariant.NEUTRAL;
        showTutorial = false;
        section = SectionVariant.STARTSCREEN;
    }

}
