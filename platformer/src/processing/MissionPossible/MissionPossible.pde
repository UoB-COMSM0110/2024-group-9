
GameState game = new GameState();
GameSettings settings = new GameSettings();
Star[] stars = new Star[950];
View currentView;
  int pos = 10;

float boxWH = 160;
PImage img;
PImage backgroundImage;

// Menu variables
PFont MPFont;
int backToMainSize;
int clickedSize;
int notClickedSize;
float menuItemWidth = 1000;
float menuItemHeight = 100;
PImage spaceship;


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
  System.out.println(leaderboard.getScores(true));
  clickedSize = 60;
  notClickedSize = 45;
}

void draw() {
  background(0);

  if(!game.started) {
    displayStartScreen();
  } 
  else if (game.section == SectionVariant.MAINMENU){
    displayMainMenu();
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

void displayStartScreen() {
  game.section = SectionVariant.STARTSCREEN;
  fill(200, 20, 0);
  textAlign(CENTER, CENTER);
  textSize(90);
  text("MISSION: POSSIBLE", displayWidth/2, displayHeight/2);
  fill(255); 
  textAlign(LEFT, BOTTOM); 
  float mainTextX = displayWidth / 2 - 400;
  float mainTextY = displayHeight / 2 - 35; 
  textSize(30);
  text("GROUP 09", mainTextX, mainTextY);
  fill(128, 128, 128);
  textAlign(CENTER, CENTER);
  textSize(30);
  text("PRESS ANY KEY TO BEGIN", displayWidth/2, displayHeight/2 + 120);
}  

void displayMainMenu(){
  textAlign(CENTER, CENTER);
  textSize(80);
  fill(200, 20, 0);
  text("Main menu", displayWidth/2, displayHeight/6);
  fill(255);
  
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 3*displayHeight/10 && mouseY <= (3*displayHeight/10)+menuItemHeight){
    textSize(clickedSize);
  }
  else{
    textSize(notClickedSize);
  }
  MainMenuItem menuItem1 = new MainMenuItem("Play Mission Possible!", 3*displayHeight/10);
  
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 4*displayHeight/10 && mouseY <= (4*displayHeight/10)+menuItemHeight){
    textSize(clickedSize);
  }
  else{
    textSize(notClickedSize);
  }
  MainMenuItem menuItem2 = new MainMenuItem("Play tutorial", 4*displayHeight/10);
  
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 5*displayHeight/10 && mouseY <= (5*displayHeight/10)+menuItemHeight){
    textSize(clickedSize);
  }
  else{
    textSize(notClickedSize);
  }
  MainMenuItem menuItem3 = new MainMenuItem("Game settings", 5*displayHeight/10);
  
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 6*displayHeight/10 && mouseY <= (6*displayHeight/10)+menuItemHeight){
    textSize(clickedSize);
  }
  else{
    textSize(notClickedSize);
  }  
  MainMenuItem menuItem4 = new MainMenuItem("View leaderboard", 6*displayHeight/10);
}

void displayChooseCharacter() {
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(80);
  text("Click to choose your character", displayWidth/2, displayHeight/6);
  fill(200, 20, 0);
  square(displayWidth/6, displayHeight/3.5, boxWH);
  square(displayWidth/2 - (boxWH/2), displayHeight/3.5, boxWH);
  square(displayWidth - (displayWidth/6) - boxWH, displayHeight/3.5, boxWH);
  square(displayWidth/6, displayHeight/1.5, boxWH);
  square(displayWidth/2 - (boxWH/2), displayHeight/1.5, boxWH);
  square(displayWidth - (displayWidth/6) - boxWH, displayHeight/1.5, boxWH);
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 9*displayHeight/10 && mouseY <= (9*displayHeight/10)+menuItemHeight){
    textSize(clickedSize);
  }  
  else{
    textSize(notClickedSize);
  }
  BackToMain backToMain = new BackToMain();
}

void enterNameScreen() {
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(80);
  text("Enter your name and press return:", displayWidth/2, displayHeight/6);
  fill(255);
  textSize(95);
  text(game.playerNickname, displayWidth/2 - 40, 400);
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 9*displayHeight/10 && mouseY <= (9*displayHeight/10)+menuItemHeight){
    textSize(clickedSize);
  }  
  else{
    textSize(notClickedSize);
  }
  BackToMain backToMain = new BackToMain();
}

void modeScreen(){
  game.section = SectionVariant.CHOOSEDIFFICULTY;
  fill(200, 20, 0);
  textAlign(CENTER, CENTER);
  textSize(60);
  text("Welcome " + game.playerNickname + "!", displayWidth/2, displayHeight/8);
  fill(255);
  textSize(80);
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
  textSize(30);
  fill(0);
  text("Easy", (displayWidth/4)+(boxWH/2), (displayHeight/2)+(boxWH/2));
  text("Difficult", displayWidth - (displayWidth/4) - (boxWH/2), (displayHeight/2)+(boxWH/2));
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 9*displayHeight/10 && mouseY <= (9*displayHeight/10)+menuItemHeight){
    textSize(clickedSize);
  }  
  else{
    textSize(notClickedSize);
  }
  BackToMain backToMain = new BackToMain();
}

void missionScreen(){
  textAlign(CENTER, CENTER);
  fill(255);
  textSize(50);
  text("Your mission is to collect the pieces of your broken spaceship \n and return to planet Earth-X4B.", displayWidth/2, displayHeight/4);
  imageMode(CENTER);
  image(spaceship, displayWidth/2, displayHeight/2);
  imageMode(CORNER);
  fill(128, 128, 128);
  textSize(30);
  text("PRESS ANY KEY TO START THE GAME", displayWidth/2, 8*displayHeight/10);
}

void gameSettingsScreen(){
  
  textAlign(CENTER, CENTER);
  fill(255);
  textSize(50);
  text("The game uses the following keyboard keys:", displayWidth/2, displayHeight/5);
  
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 3*displayHeight/10 && mouseY <= (3*displayHeight/10)+menuItemHeight){
    textSize(clickedSize);
  }
  else{
    textSize(notClickedSize);
  }
  text("Move left:  " + settings.leftKey, displayWidth/2, 3*displayHeight/10);
  
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 4*displayHeight/10 && mouseY <= (4*displayHeight/10)+menuItemHeight){
    textSize(clickedSize);
  }
  else{
    textSize(notClickedSize);
  }
  text("Move right:  " + settings.rightKey, displayWidth/2, 4*displayHeight/10);
  
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 5*displayHeight/10 && mouseY <= (5*displayHeight/10)+menuItemHeight){
    textSize(clickedSize);
  }
  else{
    textSize(notClickedSize);
  }
  text("Jump:  " + settings.jumpKey, displayWidth/2, 5*displayHeight/10);
  
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 6*displayHeight/10 && mouseY <= (6*displayHeight/10)+menuItemHeight){
    textSize(clickedSize);
  }
  else{
    textSize(notClickedSize);
  }
  text("Dash:  " + settings.dashKey, displayWidth/2, 6*displayHeight/10);
  
  textSize(50);
  fill(200, 20, 0);
  text("Click on the text above to change a key. \nYou can choose letters, numbers, characters and arrow keys.", displayWidth/2, displayHeight-(displayHeight/5));
  
  fill(255);
  if(mouseX >= displayWidth/2 - menuItemWidth/2  && mouseX <=displayWidth/2 + menuItemWidth/2 && mouseY >= 9*displayHeight/10 && mouseY <= (9*displayHeight/10)+menuItemHeight){
    textSize(clickedSize);
  }  
  else{
    textSize(notClickedSize);
  }
  BackToMain backToMain = new BackToMain();
}
  
void keyPressed() {
  if(game.section == SectionVariant.TUTORIAL || game.section == SectionVariant.GAMELEVELS){
    if (key == settings.rightKey) {
        moveRight = true;
    } 
    else if (key == settings.leftKey) {
      moveLeft = true;
    }

    if (key == settings.jumpKey) {
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
}

void keyReleased() {
  if(game.section == SectionVariant.TUTORIAL || game.section == SectionVariant.GAMELEVELS){
    if (key == settings.rightKey) {
        moveRight = false;
    } 
    else if (key == settings.leftKey) {
        moveLeft = false;
    }
    if (key == settings.jumpKey) {
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
  
  else if (game.section == SectionVariant.ENTERNAME || game.section == SectionVariant.GAMESETTINGS){
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
}
