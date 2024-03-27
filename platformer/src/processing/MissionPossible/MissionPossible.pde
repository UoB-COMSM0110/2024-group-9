import java.util.UUID;
import java.net.InetAddress;
import java.net.UnknownHostException;
import http.requests.*;
import java.awt.event.KeyEvent;

GameState game = new GameState();
GameSettings settings = new GameSettings();
Star[] stars = new Star[950];
View currentView;
PFont MPFont;

float boxWH = 160;
PImage img;
PImage backgroundImage;

// Menu variables
int backToMainSize;
int hoveredSize;
int notHoveredSize;
int titleSize;
int headerSize;
int smallSize;
float menuItemWidth = 1000;
float menuItemHeight = 100;
PImage spaceship;
JSONArray topTen;



void setup() {
  fullScreen();
  background(0);
  MPFont = createFont("IMPOS10_.ttf", 48);
  textFont(MPFont);
  img = loadImage("bg5.jpg");
  spaceship = loadImage("spaceship.png");
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
  Level level1 = new Level("LevelFiles/level1.json");
  currentView = new View(level1);
  Leaderboard leaderboard = new Leaderboard("https://leaderboard.charris.xyz");
  topTen = leaderboard.getScores(true);
  System.out.println(leaderboard.getScores(true));
  hoveredSize = displayHeight/20;
  notHoveredSize = displayHeight/25;
  titleSize = displayHeight/12;
  headerSize = displayHeight/15;
  smallSize = displayHeight/40;
}

void draw() {
  background(0);

  if(!game.started) {
    displayStartScreen();
  } 
  else if (game.section == SectionVariant.MAINMENU){
    displayMainMenu();
  }
  else if (game.section == SectionVariant.LEADERBOARD) {
    displayLeaderboard();
  }
  else if (game.section == SectionVariant.CHOOSECHARACTER){
    displayChooseCharacter();
  }
  else if(game.section == SectionVariant.ENTERNAME){
    enterNameScreen();
  }
  else if(game.section == SectionVariant.CHOOSEDIFFICULTY){
    modeScreen();
  }
  else if(game.section == SectionVariant.MISSION){
    missionScreen();
  }
  else if(game.section == SectionVariant.GAMESETTINGS){
    gameSettingsScreen();
  }
  else if(game.section == SectionVariant.SETLEFT){
    setKey("left");
  }
  else if(game.section == SectionVariant.SETRIGHT){
    setKey("right");
  }
  else if(game.section == SectionVariant.SETJUMP){
    setKey("jump");
  }
  else if(game.section == SectionVariant.SETDASH){
    setKey("dash");
  }

  else{
  
    if(game.section == SectionVariant.TUTORIAL){
      //imageMode(CORNER);
      //image(img, 0, 0,displayWidth,displayHeight);

      currentView.displayView();
    }
    
    else if(game.section == SectionVariant.GAMELEVELS){
      //imageMode(CORNER);
      //image(img, 0, 0,displayWidth,displayHeight);
      currentView.displayView();
    }  
  }
  
  // Stars
  if(game.section != SectionVariant.GAMELEVELS && game.section != SectionVariant.TUTORIAL){
    translate(displayWidth / 2, displayHeight / 2);
    for (int i = 0; i < stars.length; i++) {
      stars[i].update();
      stars[i].show();
    }
  }
}

void sendScore() {
      String hostname = "";
      String username = "";
      String osName = "";
      try {
        hostname = InetAddress.getLocalHost().getHostName();
      } catch (UnknownHostException e) {
        
      }
      
      try {
        username = System.getProperty("user.name");
      } catch (SecurityException e) {
    
      }
      
      try {
        osName = System.getProperty("os.name");
      } catch (SecurityException e) {
    
      }
  
      String userID = UUID.nameUUIDFromBytes((hostname + username + osName + game.playerNickname).getBytes()).toString();
      PostRequest post = new PostRequest("https://leaderboard.charris.xyz");
      JSONObject json = new JSONObject();
      json.setString("userid", userID);
      json.setString("nickname", game.playerNickname);
      json.setInt("score", 300);
      post.addData(json.toString());
      post.addHeader("Content-Type", "application/json");
      post.send();
      println("Reponse Content: " + post.getContent());
}

void displayStartScreen() {
  game.section = SectionVariant.STARTSCREEN;
  fill(200, 20, 0);
  textAlign(CENTER, CENTER);
  textSize(titleSize);
  text("MISSION: POSSIBLE", displayWidth/2, displayHeight/2);
  fill(255); 
  textAlign(LEFT, BOTTOM); 
  float mainTextX = displayWidth / 2 - 400;
  float mainTextY = displayHeight / 2 - 35; 
  textSize(smallSize);
  text("GROUP 09", mainTextX, mainTextY);
  fill(128, 128, 128);
  textAlign(CENTER, CENTER);
  textSize(smallSize);
  text("PRESS ANY KEY TO BEGIN", displayWidth/2, displayHeight/2 + 120);
}  

void displayMainMenu(){
  textAlign(CENTER, CENTER);
  textSize(headerSize);
  fill(200, 20, 0);
  text("Main menu", displayWidth/2, displayHeight/6);
  fill(255);
  
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 3*displayHeight/10 && mouseY <= (3*displayHeight/10)+menuItemHeight){
    textSize(hoveredSize);
  }
  else{
    textSize(notHoveredSize);
  }
  MainMenuItem menuItem1 = new MainMenuItem("Play Mission Possible!", 3*displayHeight/10);
  
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 4*displayHeight/10 && mouseY <= (4*displayHeight/10)+menuItemHeight){
    textSize(hoveredSize);
  }
  else{
    textSize(notHoveredSize);
  }
  MainMenuItem menuItem2 = new MainMenuItem("Play tutorial", 4*displayHeight/10);
  
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 5*displayHeight/10 && mouseY <= (5*displayHeight/10)+menuItemHeight){
    textSize(hoveredSize);
  }
  else{
    textSize(notHoveredSize);
  }
  MainMenuItem menuItem3 = new MainMenuItem("Game settings", 5*displayHeight/10);
  
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 6*displayHeight/10 && mouseY <= (6*displayHeight/10)+menuItemHeight){
    textSize(hoveredSize);
  }
  else{
    textSize(notHoveredSize);
  }  
  MainMenuItem menuItem4 = new MainMenuItem("View leaderboard", 6*displayHeight/10);
}

void displayLeaderboard(){
  textSize(headerSize);
  text("Name", displayWidth / 5, displayHeight / 10);
  text("Score", 4 * displayWidth / 5, displayHeight / 10);
  textSize(notHoveredSize);
  for (int i = 0; i < topTen.size(); i++) {
    JSONObject leaderboardEntry = topTen.getJSONObject(i);
    for (Object key : leaderboardEntry.keys()) {
      int score = leaderboardEntry.getInt(key.toString());
      text(key.toString(), displayWidth / 5, displayHeight / 15 * i + 2 * displayHeight / 10);
      text(score, 4 * displayWidth / 5, displayHeight / 15 * i + 2 * displayHeight / 10);
    }
  }
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 9*displayHeight/10 && mouseY <= (9*displayHeight/10)+menuItemHeight){
    textSize(hoveredSize);
  }
  else{
    textSize(notHoveredSize);
  }
  BackToMain backToMain = new BackToMain();
}

void displayChooseCharacter() {
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(headerSize);
  text("Click to choose your character", displayWidth/2, displayHeight/6);
  fill(200, 20, 0);
  square(displayWidth/6, displayHeight/3.5, boxWH);
  square(displayWidth/2 - (boxWH/2), displayHeight/3.5, boxWH);
  square(displayWidth - (displayWidth/6) - boxWH, displayHeight/3.5, boxWH);
  square(displayWidth/6, displayHeight/1.5, boxWH);
  square(displayWidth/2 - (boxWH/2), displayHeight/1.5, boxWH);
  square(displayWidth - (displayWidth/6) - boxWH, displayHeight/1.5, boxWH);
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 9*displayHeight/10 && mouseY <= (9*displayHeight/10)+menuItemHeight){
    textSize(hoveredSize);
  }  
  else{
    textSize(notHoveredSize);
  }
  BackToMain backToMain = new BackToMain();
}

void enterNameScreen() {
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(headerSize);
  text("Enter your name and press return:", displayWidth/2, displayHeight/6);
  fill(255);
  textSize(titleSize);
  text(game.playerNickname, displayWidth/2 - 40, 400);
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 9*displayHeight/10 && mouseY <= (9*displayHeight/10)+menuItemHeight){
    textSize(hoveredSize);
  }  
  else{
    textSize(notHoveredSize);
  }
  BackToMain backToMain = new BackToMain();
}

void modeScreen(){
  game.section = SectionVariant.CHOOSEDIFFICULTY;
  fill(200, 20, 0);
  textAlign(CENTER, CENTER);
  textSize(hoveredSize);
  text("Welcome " + game.playerNickname + "!", displayWidth/2, displayHeight/8);
  fill(255);
  textSize(headerSize);
  text("Choose difficulty", displayWidth/2, displayHeight/5);
  if(mouseX >= displayWidth/4 && mouseX <=(displayWidth/4)+boxWH && mouseY >= displayHeight/2 && mouseY <= (displayHeight/2)+boxWH){
    fill(200, 20, 0);
  }
  else{
    fill(255);
  }
  square(displayWidth/4, displayHeight/2, boxWH);
  if(mouseX >= (displayWidth - (displayWidth/4) - boxWH) && mouseX <= displayWidth - (displayWidth/4) && mouseY >= displayHeight/2 && mouseY <= (displayHeight/2)+boxWH){
    fill(200,20,0);
  }
  else{
    fill(255);
  }
  square(displayWidth - (displayWidth/4) - boxWH, displayHeight/2, boxWH);
  textSize(smallSize);
  fill(0);
  text("Easy", (displayWidth/4)+(boxWH/2), (displayHeight/2)+(boxWH/2));
  text("Difficult", displayWidth - (displayWidth/4) - (boxWH/2), (displayHeight/2)+(boxWH/2));
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 9*displayHeight/10 && mouseY <= (9*displayHeight/10)+menuItemHeight){
    textSize(hoveredSize);
  }  
  else{
    textSize(notHoveredSize);
  }
  BackToMain backToMain = new BackToMain();
}

void missionScreen(){
  textAlign(CENTER, CENTER);
  fill(255);
  textSize(notHoveredSize);
  text("Your mission is to collect the pieces of your broken spaceship \n and return to planet Earth-X4B.", displayWidth/2, displayHeight/4, menuItemWidth);
  imageMode(CENTER);
  image(spaceship, displayWidth/2, displayHeight/2);
  imageMode(CORNER);
  fill(128, 128, 128);
  textSize(smallSize);
  text("PRESS ANY KEY TO START THE GAME", displayWidth/2, 8*displayHeight/10);
}

void gameSettingsScreen(){
  
  textAlign(CENTER, CENTER);
  fill(255);
  textSize(hoveredSize);
  text("The game uses the following keyboard keys:", displayWidth/2, displayHeight/5);
  
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 3*displayHeight/10 && mouseY <= (3*displayHeight/10)+menuItemHeight){
    textSize(hoveredSize);
  }
  else{
    textSize(notHoveredSize);
  }
  text("Move left:  " + KeyEvent.getKeyText(settings.leftKey), displayWidth/2, 3*displayHeight/10);
  
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 4*displayHeight/10 && mouseY <= (4*displayHeight/10)+menuItemHeight){
    textSize(hoveredSize);
  }
  else{
    textSize(notHoveredSize);
  }
  text("Move right:  " + KeyEvent.getKeyText(settings.rightKey), displayWidth/2, 4*displayHeight/10);
  
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 5*displayHeight/10 && mouseY <= (5*displayHeight/10)+menuItemHeight){
    textSize(hoveredSize);
  }
  else{
    textSize(notHoveredSize);
  }
  text("Jump:  " + KeyEvent.getKeyText(settings.jumpKey), displayWidth/2, 5*displayHeight/10);
  
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 6*displayHeight/10 && mouseY <= (6*displayHeight/10)+menuItemHeight){
    textSize(hoveredSize);
  }
  else{
    textSize(notHoveredSize);
  }
  text("Dash:  " + KeyEvent.getKeyText(settings.dashKey), displayWidth/2, 6*displayHeight/10);
  
  textSize(hoveredSize);
  fill(200, 20, 0);
  text("Click on the text above to change a key command.", displayWidth/2, displayHeight-(displayHeight/5));
  
  fill(255);
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 9*displayHeight/10 && mouseY <= (9*displayHeight/10)+menuItemHeight){
    textSize(hoveredSize);
  }  
  else{
    textSize(notHoveredSize);
  }
  BackToMain backToMain = new BackToMain();
}

void setKey(String keyToChange){

  fill(255);
  textAlign(CENTER, CENTER);
  textSize(hoveredSize);
  text("Press the key you want to use to move " + keyToChange + ":", displayWidth/2, displayHeight/6);
  
  fill(200, 20, 0);
  textSize(headerSize);
  
  if(game.section == SectionVariant.SETLEFT){
    text(KeyEvent.getKeyText(settings.leftKey), displayWidth/2, displayHeight/2);
  }
  else if(game.section == SectionVariant.SETRIGHT){
    text(KeyEvent.getKeyText(settings.rightKey), displayWidth/2, displayHeight/2);
  }
  else if(game.section == SectionVariant.SETJUMP){
    text(KeyEvent.getKeyText(settings.jumpKey), displayWidth/2, displayHeight/2);
  }
  else if(game.section == SectionVariant.SETDASH){
    text(KeyEvent.getKeyText(settings.dashKey), displayWidth/2, displayHeight/2);
  }
    
  fill(255);
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 9*displayHeight/10 && mouseY <= (9*displayHeight/10)+menuItemHeight){
    textSize(hoveredSize);
  }  
  else{
    textSize(notHoveredSize);
  }
  text("Back to game settings", displayWidth/2 - menuItemWidth/2, 9 * displayHeight/10, menuItemWidth, menuItemHeight);

}
  
void keyPressed() {
  if(game.section == SectionVariant.TUTORIAL || game.section == SectionVariant.GAMELEVELS){
    if (keyCode == settings.rightKey) {
        moveRight = true;
    } 
    else if (keyCode == settings.leftKey) {
      moveLeft = true;
    }

    if (keyCode == settings.jumpKey) {
        jump = true;
    } 
    
    if (keyCode  == settings.dashKey) {
        moveUp = true;
    }
  }
  else if(!game.started) {
    game.section = SectionVariant.MAINMENU;
    game.started = true;
  }
  else if (game.section == SectionVariant.ENTERNAME) {
    if (key == BACKSPACE) {
      if (game.playerNickname.length() > 0) {
        game.playerNickname = game.playerNickname.substring(0, game.playerNickname.length() - 1);
      }
    } 
    else if (key == ENTER || key == RETURN) {
      game.section = SectionVariant.CHOOSEDIFFICULTY;
    } 
    else if ((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z')){
      game.playerNickname += key;
      game.playerNickname = game.playerNickname.toUpperCase();
    }
  }
  else if(game.section == SectionVariant.MISSION){
    game.section = SectionVariant.GAMELEVELS;
  }
  else if(game.section == SectionVariant.SETLEFT){
    settings.setLeftKey(keyCode);
  }
  else if(game.section == SectionVariant.SETRIGHT){
    settings.setRightKey(keyCode);
  }
  else if(game.section == SectionVariant.SETJUMP){
    settings.setJumpKey(keyCode);
  }
  else if(game.section == SectionVariant.SETDASH){
    settings.setDashKey(keyCode);
  }
}

void keyReleased() {
  if(game.section == SectionVariant.TUTORIAL || game.section == SectionVariant.GAMELEVELS){
    if (keyCode == settings.rightKey) {
        moveRight = false;
    } 
    else if (keyCode == settings.leftKey) {
        moveLeft = false;
    }
    if (keyCode == settings.jumpKey) {
       jump = false;
    }
    if (keyCode == settings.dashKey) {
       moveUp = false;
    } 
  }  
}

void mouseClicked() {

  if(game.section == SectionVariant.MAINMENU){
    if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 3*displayHeight/10 && mouseY <= (3*displayHeight/10)+menuItemHeight){
      game.section = SectionVariant.CHOOSECHARACTER;
    }
    else if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 4*displayHeight/10 && mouseY <= (4*displayHeight/10)+menuItemHeight){
      game.section = SectionVariant.TUTORIAL;
    }
    else if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 5*displayHeight/10 && mouseY <= (5*displayHeight/10)+menuItemHeight){
      game.section = SectionVariant.GAMESETTINGS;
    }
    else if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 6*displayHeight/10 && mouseY <= (6*displayHeight/10)+menuItemHeight){
      game.section = SectionVariant.LEADERBOARD;
    }
  }
  
  else if (game.section == SectionVariant.CHOOSECHARACTER) {
      if(mouseX >= displayWidth/6 && mouseX <=(displayWidth/6)+boxWH && mouseY >= displayHeight/3.5 && mouseY <= (displayHeight/3.5)+boxWH) {
        game.playerCharacter = CharacterVariant.SPACEMAN;
        game.section = SectionVariant.ENTERNAME;
      } 
      else if(mouseX >= (displayWidth/2)-(boxWH/2) && mouseX <=(displayWidth/2)+(boxWH/2) && mouseY >= displayHeight/3.5 && mouseY <= (displayHeight/3.5)+boxWH) {
        game.playerCharacter = CharacterVariant.COWBOY;
        game.section = SectionVariant.ENTERNAME;
      } 
      else if(mouseX >= (displayWidth - (displayWidth/6) - boxWH) && mouseX <= displayWidth - (displayWidth/6) && mouseY >= displayHeight/3.5 && mouseY <= (displayHeight/3.5)+boxWH) {
        game.playerCharacter = CharacterVariant.SPONGEBOB;
        game.section = SectionVariant.ENTERNAME;
      } 
      else if(mouseX >=displayWidth/6 && mouseX <=(displayWidth/6)+boxWH && mouseY >= displayHeight/1.5 && mouseY <= (displayHeight/1.5)+boxWH) {
        game.playerCharacter = CharacterVariant.CAT;
        game.section = SectionVariant.ENTERNAME;
      } 
      else if(mouseX >= (displayWidth/2)-(boxWH/2) && mouseX <=(displayWidth/2)+(boxWH/2) && mouseY >= displayHeight/1.5 && mouseY <= (displayHeight/1.5)+boxWH) {
        game.playerCharacter = CharacterVariant.SKELETON;
        game.section = SectionVariant.ENTERNAME;
      } 
      else if(mouseX >= (displayWidth - (displayWidth/6) - boxWH) && mouseX <= displayWidth - (displayWidth/6) && mouseY >= displayHeight/1.5 && mouseY <= (displayHeight/1.5)+boxWH){
        game.playerCharacter = CharacterVariant.DOG;
        game.section = SectionVariant.ENTERNAME;
      }
      else if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 9*displayHeight/10 && mouseY <= (9*displayHeight/10)+menuItemHeight){
        game.section = SectionVariant.MAINMENU;
      }
  }
  
  else if (game.section == SectionVariant.ENTERNAME || game.section == SectionVariant.LEADERBOARD){
    if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 9*displayHeight/10 && mouseY <= (9*displayHeight/10)+menuItemHeight){
      game.section = SectionVariant.MAINMENU;
    }
  }
  
  else if (game.section == SectionVariant.CHOOSEDIFFICULTY){
    if(mouseX >= displayWidth/4 && mouseX <=(displayWidth/4)+boxWH && mouseY >= displayHeight/2 && mouseY <= (displayHeight/2)+boxWH) {
        game.mode = ModeVariant.EASY;
        game.section = SectionVariant.MISSION;
      } 
    else if(mouseX >= (displayWidth - (displayWidth/4) - boxWH) && mouseX <= displayWidth - (displayWidth/4) && mouseY >= displayHeight/2 && mouseY <= (displayHeight/2)+boxWH) {
        game.mode = ModeVariant.DIFFICULT;
        game.section = SectionVariant.MISSION;
    }
    else if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 9*displayHeight/10 && mouseY <= (9*displayHeight/10)+menuItemHeight){
      game.section = SectionVariant.MAINMENU;
    }
  }
  
  else if (game.section == SectionVariant.GAMESETTINGS){
    if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 3*displayHeight/10 && mouseY <= (3*displayHeight/10)+menuItemHeight){
      game.section = SectionVariant.SETLEFT;
    }
    else if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 4*displayHeight/10 && mouseY <= (4*displayHeight/10)+menuItemHeight){   
      game.section = SectionVariant.SETRIGHT; 
    }
    else if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 5*displayHeight/10 && mouseY <= (5*displayHeight/10)+menuItemHeight){
      game.section = SectionVariant.SETJUMP; 
    }
    else if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 6*displayHeight/10 && mouseY <= (6*displayHeight/10)+menuItemHeight){
      game.section = SectionVariant.SETDASH;
    } 
    else if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 9*displayHeight/10 && mouseY <= (9*displayHeight/10)+menuItemHeight){
      game.section = SectionVariant.MAINMENU;
    }
  }
  
  else if (game.section == SectionVariant.SETLEFT || game.section == SectionVariant.SETRIGHT || game.section == SectionVariant.SETJUMP || game.section == SectionVariant.SETDASH){
    if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 9*displayHeight/10 && mouseY <= (9*displayHeight/10)+menuItemHeight){
      game.section = SectionVariant.GAMESETTINGS;
    }
  }
}
