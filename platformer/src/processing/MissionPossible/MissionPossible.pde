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
Leaderboard leaderboard = new Leaderboard("https://leaderboard.charris.xyz");

float boxWH = 160;
PImage backgroundImage;
float y = displayHeight;  
Animation spaceman;
Animation cowboy;
Animation fox;
Animation cat;
Animation skeleton;
Animation wolf;
Level currentLevel;

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
String creditText;

void setup() {
  fullScreen(P2D);
  background(0);
  MPFont = createFont("IMPOS10_.ttf", 48);
  textFont(MPFont);
  spaceship = loadImage("spaceship.png");
  spaceman = new Animation("spaceman", "standing");
  cowboy = new Animation("cowboy", "standing");
  fox = new Animation("fox", "standing");
  cat = new Animation("cat", "standing");
  skeleton = new Animation("skeleton", "standing");
  wolf = new Animation("wolf", "standing");
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
  hoveredSize = displayHeight/20;
  notHoveredSize = displayHeight/25;
  titleSize = displayHeight/12;
  headerSize = displayHeight/15;
  smallSize = displayHeight/40;
  
  String[] lines = loadStrings("credits.txt");
  creditText = join(lines, "\n");
  
}

void draw() {
  background(0);
  selectScreen();
}

// Select between menu screens and game play screens
void selectScreen(){
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
    displayEnterNameScreen();
  }
  else if(game.section == SectionVariant.CHOOSEDIFFICULTY){
    displayModeScreen();
  }
  else if(game.section == SectionVariant.MISSION){
    displayMissionScreen();
  }
  else if(game.section == SectionVariant.GAMESETTINGS){
    displayGameSettingsScreen();
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
  else if(game.section == SectionVariant.RESTARTLEVEL){
    displayRestartLevel();
  }
  else if(game.section == SectionVariant.GAMEOVER){
    displayRestartGame();
  }
  else if(game.section == SectionVariant.CREDITS){
    displayCredits();
  }
  else if(game.section == SectionVariant.TUTORIAL || game.section == SectionVariant.GAMELEVELS){
    currentView.displayView();
  }
  
  // Opening screen stars
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
      json.setInt("score", 301);
      post.addData(json.toString());
      post.addHeader("Content-Type", "application/json");
      post.send();
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
  text("CLICK ANYWHERE TO BEGIN", displayWidth/2, displayHeight/2 + 120);
}  

void displayMainMenu(){
  textAlign(CENTER, CENTER);
  textSize(headerSize);
  fill(200, 20, 0);
  text("Main menu", displayWidth/2, displayHeight/6);
  fill(255);

  hoverTextSize(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 3*displayHeight/10, (3*displayHeight/10)+menuItemHeight);
  MainMenuItem menuItem1 = new MainMenuItem("Play Mission Possible!", 3*displayHeight/10);
  
  hoverTextSize(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 4*displayHeight/10, (4*displayHeight/10)+menuItemHeight);
  MainMenuItem menuItem2 = new MainMenuItem("Play tutorial", 4*displayHeight/10);
  
  hoverTextSize(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 5*displayHeight/10, (5*displayHeight/10)+menuItemHeight);
  MainMenuItem menuItem3 = new MainMenuItem("Game settings", 5*displayHeight/10);
   
  hoverTextSize(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 6*displayHeight/10, (6*displayHeight/10)+menuItemHeight);
  MainMenuItem menuItem4 = new MainMenuItem("View leaderboard", 6*displayHeight/10);
  
  hoverTextSize(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 7*displayHeight/10, (7*displayHeight/10)+menuItemHeight);
  MainMenuItem menuItem5 = new MainMenuItem("View game credits", 7*displayHeight/10);
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
  BackToMain backToMain = new BackToMain();
}

void displayChooseCharacter() {
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(headerSize);
  text("Click to choose your character", displayWidth/2, displayHeight/6);
  fill(200, 20, 0);
  image(spaceman.nextFrame(1)  , displayWidth/6, displayHeight/3.5, boxWH, boxWH);
  hoverCharacter(displayWidth/6, (displayWidth/6)+boxWH, displayHeight/3.5, (displayHeight/3.5)+boxWH, "Spaceman");
  image(cowboy.nextFrame(1), displayWidth/2 - (boxWH/2), displayHeight/3.5, boxWH, boxWH);
  hoverCharacter((displayWidth/2)-(boxWH/2), (displayWidth/2)+(boxWH/2), displayHeight/3.5, (displayHeight/3.5)+boxWH, "Cowboy");
  image(fox.nextFrame(1), displayWidth - (displayWidth/6) - boxWH, displayHeight/3.5, boxWH, boxWH);
  hoverCharacter(displayWidth - (displayWidth/6) - boxWH, displayWidth - (displayWidth/6), displayHeight/3.5, (displayHeight/3.5)+boxWH, "Fox");
  image(cat.nextFrame(1), displayWidth/6, displayHeight/1.5, boxWH, boxWH);
  hoverCharacter(displayWidth/6, (displayWidth/6)+boxWH, displayHeight/1.5, (displayHeight/1.5)+boxWH, "Cat");
  image(skeleton.nextFrame(1), displayWidth/2 - (boxWH/2), displayHeight/1.5, boxWH, boxWH);
  hoverCharacter((displayWidth/2)-(boxWH/2), (displayWidth/2)+(boxWH/2), displayHeight/1.5, (displayHeight/1.5)+boxWH, "Skeleton");
  image(wolf.nextFrame(1), displayWidth - (displayWidth/6) - boxWH, displayHeight/1.5, boxWH, boxWH);
  hoverCharacter(displayWidth - (displayWidth/6) - boxWH, displayWidth - (displayWidth/6), displayHeight/1.5, (displayHeight/1.5)+boxWH, "Wolf");
  BackToMain backToMain = new BackToMain();
}

void displayEnterNameScreen() {
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(headerSize);
  text("Enter your name and press return:", displayWidth/2, displayHeight/6);
  fill(255);
  textSize(titleSize);
  text(game.playerNickname, displayWidth/2 - 40, 400);
  BackToMain backToMain = new BackToMain();
}

void displayModeScreen(){
  game.section = SectionVariant.CHOOSEDIFFICULTY;
  fill(200, 20, 0);
  textAlign(CENTER, CENTER);
  textSize(hoveredSize);
  text("Welcome " + game.playerNickname + "!", displayWidth/2, displayHeight/8);
  fill(255);
  textSize(headerSize);
  text("Choose difficulty", displayWidth/2, displayHeight/5);

  hoverBoxColour(displayWidth/4, (displayWidth/4)+boxWH, displayHeight/2, (displayHeight/2)+boxWH);
  square(displayWidth/4, displayHeight/2, boxWH);
 
  hoverBoxColour((displayWidth - (displayWidth/4)- boxWH), displayWidth - (displayWidth/4), displayHeight/2, (displayHeight/2)+boxWH);
  square(displayWidth - (displayWidth/4) - boxWH, displayHeight/2, boxWH);
  
  textSize(smallSize);
  fill(0);
  textAlign(CENTER);
  text("Easy", (displayWidth/4)+(boxWH/2), (displayHeight/2)+(boxWH/2));
  text("Difficult", displayWidth - (displayWidth/4) - (boxWH/2), (displayHeight/2)+(boxWH/2));
  BackToMain backToMain = new BackToMain();
}

void displayMissionScreen(){
  textAlign(CENTER, CENTER);
  fill(255);
  textSize(notHoveredSize);
  text("Your mission is to collect the pieces of your broken spaceship \n and return to planet Earth-X4B.", displayWidth/2, displayHeight/4, menuItemWidth);
  imageMode(CENTER);
  image(spaceship, displayWidth/2, displayHeight/2);
  imageMode(CORNER);
  fill(128, 128, 128);
  textSize(smallSize);
  text("CLICK ANYWHERE TO START THE GAME", displayWidth/2, 8*displayHeight/10);
}

void displayGameSettingsScreen(){
  
  textAlign(CENTER, CENTER);
  fill(255);
  textSize(hoveredSize);
  text("The game uses the following keyboard keys:", displayWidth/2, displayHeight/5);
  
  hoverTextSize(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 3*displayHeight/10, (3*displayHeight/10)+menuItemHeight);
  text("Move left:  " + KeyEvent.getKeyText(settings.leftKey), displayWidth/2, 3*displayHeight/10);
  
  hoverTextSize(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 4*displayHeight/10, (4*displayHeight/10)+menuItemHeight);
  text("Move right:  " + KeyEvent.getKeyText(settings.rightKey), displayWidth/2, 4*displayHeight/10);
  
  hoverTextSize(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 5*displayHeight/10, (5*displayHeight/10)+menuItemHeight);
  text("Jump:  " + KeyEvent.getKeyText(settings.jumpKey), displayWidth/2, 5*displayHeight/10);
  
  hoverTextSize(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 6*displayHeight/10, (6*displayHeight/10)+menuItemHeight);
  text("Dash:  " + KeyEvent.getKeyText(settings.dashKey), displayWidth/2, 6*displayHeight/10);
  
  textSize(hoveredSize);
  fill(200, 20, 0);
  text("Click on the text above to change a key command.", displayWidth/2, displayHeight-(displayHeight/5));
  
  fill(255);
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
  hoverTextSize(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 9*displayHeight/10, (9*displayHeight/10)+menuItemHeight);
  text("Back to game settings", displayWidth/2 - menuItemWidth/2, 9 * displayHeight/10, menuItemWidth, menuItemHeight);
}

void displayRestartLevel(){
  fill(200, 20, 0);
  textAlign(CENTER, CENTER);
  textSize(hoveredSize);
  text("Oh no, you lost all your lives!", displayWidth/2, displayHeight/6);
  fill(255);
  hoverTextSize(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 3*displayHeight/10, (3*displayHeight/10)+menuItemHeight);
  text("Click here to restart level", displayWidth/2, 3*displayHeight/10);
  fill(255);
  BackToMain backToMain = new BackToMain();
}

void displayRestartGame(){
  fill(200, 20, 0);
  textAlign(CENTER, CENTER);
  textSize(titleSize);
  text("GAME OVER", displayWidth/2, displayHeight/6);
  textSize(hoveredSize);
  text("You lost all your lives!", displayWidth/2, displayHeight/3);
  fill(255);
  text("Click anywhere to submit your score\n and return to the main menu.", displayWidth/2, displayHeight/2);
}

void displayCredits(){
  fill(255);
  textAlign(CENTER);
  textSize(notHoveredSize);
  text(creditText, width*0.05, y, width*0.9, height*3);
  y--;
}

void enterLevel(String levelName){
  game.level = levelName;
  currentLevel = new Level(game.level+File.separator+game.level+".json");
  currentView = new View(currentLevel);  
}
  
void keyPressed() {
  
  if(game.section != SectionVariant.TUTORIAL && game.section != SectionVariant.GAMELEVELS){
    moveRight = false;
    moveLeft = false;
    jump = false;
    moveUp = false;
  }
  
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
  else if (game.section == SectionVariant.ENTERNAME) {
    if (key == BACKSPACE) {
      if (game.playerNickname.length() > 0) {
        game.playerNickname = game.playerNickname.substring(0, game.playerNickname.length() - 1);
      }
    } 
    else if ((key == ENTER || key == RETURN) && game.playerNickname != "") {
      game.section = SectionVariant.CHOOSEDIFFICULTY;
    } 
    else if ((key >= 'A' && key <= 'Z') || (key >= 'a' && key <= 'z')){
      game.playerNickname += key;
      game.playerNickname = game.playerNickname.toUpperCase();
    }
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
  if(game.section == SectionVariant.TUTORIAL){
    if(currentView.currentInstructionIndex == 0 && currentView.rightCompleted == false && keyCode == settings.rightKey){
      currentView.currentInstructionIndex++;
      currentView.rightCompleted = true;
    }
    if(currentView.currentInstructionIndex == 1 && currentView.leftCompleted == false && keyCode == settings.leftKey){
      currentView.currentInstructionIndex++;
      currentView.leftCompleted = true;
    }
    if(currentView.currentInstructionIndex == 2 && currentView.jumpCompleted == false && keyCode == settings.jumpKey){
      currentView.currentInstructionIndex++;
      currentView.jumpCompleted = true;
    }
    if(currentView.currentInstructionIndex == 3 && currentView.dashCompleted == false && keyCode == settings.dashKey){
      currentView.currentInstructionIndex++;
      currentView.dashCompleted = true;
    }
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
  } else {
    moveRight = false;
    moveLeft = false;
    jump = false;
    moveUp = false;
  }
}

void mouseClicked() {
  if(!game.started) {
    game.section = SectionVariant.MAINMENU;
    game.started = true;
  }
  else if(game.section == SectionVariant.MAINMENU){
    menuClicks(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 3*displayHeight/10, (3*displayHeight/10)+menuItemHeight, SectionVariant.CHOOSECHARACTER);
    menuClicks(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 4*displayHeight/10, (4*displayHeight/10)+menuItemHeight, SectionVariant.TUTORIAL);
    menuClicks(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 5*displayHeight/10, (5*displayHeight/10)+menuItemHeight, SectionVariant.GAMESETTINGS);
    if (mouseX >= displayWidth/2 - menuItemWidth/2 && mouseX <= displayWidth/2 + menuItemWidth/2 && mouseY >= 6*displayHeight/10 && mouseY <= 6*displayHeight/10 + menuItemHeight) {
      topTen = leaderboard.getScores(true);
    }
    menuClicks(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 6*displayHeight/10, (6*displayHeight/10)+menuItemHeight, SectionVariant.LEADERBOARD);
    menuClicks(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 7*displayHeight/10, (7*displayHeight/10)+menuItemHeight, SectionVariant.CREDITS);
     
    if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <= displayWidth/2 + menuItemWidth/2 && mouseY >= 4*displayHeight/10 && mouseY <= (4*displayHeight/10)+menuItemHeight){
      game.playerCharacter = CharacterVariant.SPACEMAN;
      enterLevel("tutorial");
    }   
  }
  else if (game.section == SectionVariant.CHOOSECHARACTER) {
    characterClicks(displayWidth/6, (displayWidth/6)+boxWH, displayHeight/3.5, (displayHeight/3.5)+boxWH, CharacterVariant.SPACEMAN, SectionVariant.ENTERNAME);
    characterClicks((displayWidth/2)-(boxWH/2), (displayWidth/2)+(boxWH/2), displayHeight/3.5, (displayHeight/3.5)+boxWH, CharacterVariant.COWBOY, SectionVariant.ENTERNAME);
    characterClicks(displayWidth - (displayWidth/6) - boxWH, displayWidth - (displayWidth/6), displayHeight/3.5, (displayHeight/3.5)+boxWH, CharacterVariant.FOX, SectionVariant.ENTERNAME);
    characterClicks(displayWidth/6, (displayWidth/6)+boxWH, displayHeight/1.5, (displayHeight/1.5)+boxWH, CharacterVariant.CAT, SectionVariant.ENTERNAME);
    characterClicks((displayWidth/2)-(boxWH/2), (displayWidth/2)+(boxWH/2), displayHeight/1.5, (displayHeight/1.5)+boxWH, CharacterVariant.SKELETON,SectionVariant.ENTERNAME);
    characterClicks(displayWidth - (displayWidth/6) - boxWH, displayWidth - (displayWidth/6), displayHeight/1.5, (displayHeight/1.5)+boxWH, CharacterVariant.WOLF, SectionVariant.ENTERNAME);
    menuClicks(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 9*displayHeight/10, (9*displayHeight/10)+menuItemHeight, SectionVariant.MAINMENU);
  }
  else if (game.section == SectionVariant.ENTERNAME || game.section == SectionVariant.LEADERBOARD){
    menuClicks(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 9*displayHeight/10, (9*displayHeight/10)+menuItemHeight, SectionVariant.MAINMENU);
  }
  else if (game.section == SectionVariant.CHOOSEDIFFICULTY){
    modeClicks(displayWidth/4, (displayWidth/4)+boxWH, displayHeight/2, (displayHeight/2)+boxWH, ModeVariant.EASY, SectionVariant.MISSION);
    modeClicks(displayWidth - (displayWidth/4) - boxWH, displayWidth - (displayWidth/4), displayHeight/2, (displayHeight/2)+boxWH, ModeVariant.DIFFICULT, SectionVariant.MISSION);
    menuClicks(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 9*displayHeight/10, (9*displayHeight/10)+menuItemHeight, SectionVariant.MAINMENU);
  }
  else if (game.section == SectionVariant.GAMESETTINGS){
    menuClicks(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 3*displayHeight/10, (3*displayHeight/10)+menuItemHeight, SectionVariant.SETLEFT);
    menuClicks(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 4*displayHeight/10, (4*displayHeight/10)+menuItemHeight, SectionVariant.SETRIGHT);
    menuClicks(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 5*displayHeight/10, (5*displayHeight/10)+menuItemHeight, SectionVariant.SETJUMP);
    menuClicks(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 6*displayHeight/10, (6*displayHeight/10)+menuItemHeight, SectionVariant.SETDASH);
    menuClicks(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 9*displayHeight/10, (9*displayHeight/10)+menuItemHeight, SectionVariant.MAINMENU);
  } 
  else if (game.section == SectionVariant.SETLEFT || game.section == SectionVariant.SETRIGHT || game.section == SectionVariant.SETJUMP || game.section == SectionVariant.SETDASH){
    if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 9*displayHeight/10 && mouseY <= (9*displayHeight/10)+menuItemHeight){
      game.section = SectionVariant.GAMESETTINGS;
    }
  }
  else if(game.section == SectionVariant.MISSION){
    game.section = SectionVariant.GAMELEVELS;
    enterLevel("level1");
  }
  else if (game.section == SectionVariant.TUTORIAL || game.section == SectionVariant.CREDITS){
    game.section = SectionVariant.MAINMENU;
  }
  else if (game.section == SectionVariant.RESTARTLEVEL){
    if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <= displayWidth/2 + menuItemWidth/2 && mouseY >= 3*displayHeight/10 && mouseY <= (3*displayHeight/10)+menuItemHeight){
      game.section = SectionVariant.GAMELEVELS;
      enterLevel("level1");
    }
    menuClicks(displayWidth/2 - menuItemWidth/2, displayWidth/2 + menuItemWidth/2, 9*displayHeight/10, (9*displayHeight/10)+menuItemHeight, SectionVariant.MAINMENU);
  }
  else if(game.section == SectionVariant.GAMEOVER){
    game.section = SectionVariant.MAINMENU;
  }
}

void hoverTextSize(float xMin, float xMax, float yMin, float yMax){
  if(mouseX >= xMin  && mouseX <= xMax && mouseY >= yMin && mouseY <= yMax){
    textSize(hoveredSize);
  }
  else{
    textSize(notHoveredSize);
  }
}

void hoverBoxColour(float xMin, float xMax, float yMin, float yMax){
  if(mouseX >= xMin  && mouseX <= xMax && mouseY >= yMin && mouseY <= yMax){
    fill(200, 20, 0);
  }
  else{
    fill(255);
  }
}

void hoverCharacter (float xMin, float xMax, float yMin, float yMax, String character){
  if(mouseX >= xMin  && mouseX <= xMax && mouseY >= yMin && mouseY <= yMax){
    textSize(hoveredSize);
    fill(200, 20, 0);
    text(character, displayWidth/2, displayHeight/2);
  }   
}

void menuClicks(float xMin, float xMax, float yMin, float yMax, SectionVariant section){
  if(mouseX >= xMin  && mouseX <= xMax && mouseY >= yMin && mouseY <= yMax){
    game.section = section;
  }
}

void characterClicks(float xMin, float xMax, float yMin, float yMax, CharacterVariant character, SectionVariant section){
  if(mouseX >= xMin  && mouseX <= xMax && mouseY >= yMin && mouseY <= yMax){
    game.playerCharacter = character;
    game.section = section;
  }
}

void modeClicks(float xMin, float xMax, float yMin, float yMax, ModeVariant mode, SectionVariant section){
  if(mouseX >= xMin  && mouseX <= xMax && mouseY >= yMin && mouseY <= yMax){
    game.mode = mode;
    game.section = section;
  }   
}
