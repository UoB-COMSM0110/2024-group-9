
GameState game = new GameState();
Star[] stars = new Star[950];
View currentView;
  int pos = 10;
PFont MPFont;
float boxWH = 160;


void setup() {
  fullScreen();
  background(0);
  MPFont = createFont("IMPOS10_.ttf", 48);
  textFont(MPFont);
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
  Level level1 = new Level("LevelFiles/level1.json");
  currentView = new View(level1);
  Leaderboard leaderboard = new Leaderboard("https://leaderboard.charris.xyz");
  System.out.println(leaderboard.getScores(true));
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
  else {
    if(game.showTutorial){
      game.section = SectionVariant.TUTORIAL;
    }
    else{
      game.section = SectionVariant.GAMELEVELS;
    }
    PImage img;
    img = loadImage("bg5.jpg");
    imageMode(CORNER);
    image(img,0,0,displayWidth,displayHeight);
    currentView.displayView();
  }
  
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
  MainMenuItem menuItem1 = new MainMenuItem("Play Mission Possible!", 2*displayHeight/10);
  MainMenuItem menuItem2 = new MainMenuItem("Play tutorial", 3*displayHeight/10);
  MainMenuItem menuItem3 = new MainMenuItem("Game settings", 4*displayHeight/10);
  MainMenuItem menuItem4 = new MainMenuItem("View leaderboard", 5*displayHeight/10); 
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
  fill(200,20,0);
  BackToMain backToMain = new BackToMain();
}

void enterNameScreen() {
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(80);
  text("Enter your name:", displayWidth/2, displayHeight/6);
  fill(255);
  textSize(95);
  text(game.playerNickname, displayWidth/2 - 40, 400);
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
  fill(200, 20, 0);
  square(displayWidth/4, displayHeight/2, boxWH);
  square(displayWidth - (displayWidth/4) - boxWH, displayHeight/2, boxWH);
  textSize(30);
  fill(255);
  text("Easy", (displayWidth/4)+(boxWH/2), (displayHeight/2)+(boxWH/2));
  text("Difficult", displayWidth - (displayWidth/4) - (boxWH/2), (displayHeight/2)+(boxWH/2));
  BackToMain backToMain = new BackToMain();
}
  
void keyPressed() {
  if(game.section == SectionVariant.TUTORIAL || game.section == SectionVariant.GAMELEVELS){
      if (key == 'd') {
        moveRight = true;
    } else if (key == 'a') {
        moveLeft = true;
    }

    if (key == 'w') {
        moveUp = true;
    } else if (key == 's') {
        moveDown = true;
    }
  }
  else{
  if(!game.started) {
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
      }
    }
  }
}

void mouseClicked() {

  if(game.section == SectionVariant.MAINMENU){
    if(mouseX >= displayWidth/2 - 375  && mouseX <=displayWidth/2 + 375 && mouseY >= 2*displayHeight/10 && mouseY <= (2*displayHeight/10)+boxWH){
      game.section = SectionVariant.CHOOSECHARACTER;
    }
    else if(mouseX >= displayWidth/2 - 375  && mouseX <=displayWidth/2 + 375 && mouseY >= 3*displayHeight/10 && mouseY <= (3*displayHeight/10)+boxWH){
      game.section = SectionVariant.TUTORIAL;
    }
    else if(mouseX >= displayWidth/2 - 375  && mouseX <=displayWidth/2 + 375 && mouseY >= 4*displayHeight/10 && mouseY <= (4*displayHeight/10)+boxWH){
      game.section = SectionVariant.GAMESETTINGS;
    }
    else if(mouseX >= displayWidth/2 - 375  && mouseX <=displayWidth/2 + 375 && mouseY >= 5*displayHeight/10 && mouseY <= (5*displayHeight/10)+boxWH){
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
      else if(mouseX >= displayWidth/2 - 375  && mouseX <=displayWidth/2 + 375 && mouseY >= 9*displayHeight/10 && mouseY <= (9*displayHeight/10)+boxWH){
        game.section = SectionVariant.MAINMENU;
      }
  }
  
  else if (game.section == SectionVariant.ENTERNAME){
    if(mouseX >= displayWidth/2 - 375  && mouseX <=displayWidth/2 + 375 && mouseY >= 9*displayHeight/10 && mouseY <= (9*displayHeight/10)+boxWH){
      game.section = SectionVariant.MAINMENU;
    }
  }
  
  else if (game.section == SectionVariant.CHOOSEDIFFICULTY){
    if(mouseX >= displayWidth/4 && mouseX <=(displayWidth/4)+boxWH && mouseY >= displayHeight/2 && mouseY <= (displayHeight/2)+boxWH) {
        game.mode = ModeVariant.EASY;
        game.section = SectionVariant.GAMELEVELS;
      } 
    else if(mouseX >= (displayWidth - (displayWidth/4) - boxWH) && mouseX <= displayWidth - (displayWidth/4) && mouseY >= displayHeight/2 && mouseY <= (displayHeight/2)+boxWH) {
        game.mode = ModeVariant.DIFFICULT;
        game.section = SectionVariant.GAMELEVELS;
    }
    else if(mouseX >= displayWidth/2 - 375  && mouseX <=displayWidth/2 + 375 && mouseY >= 9*displayHeight/10 && mouseY <= (9*displayHeight/10)+boxWH){
      game.section = SectionVariant.MAINMENU;
    }
  }
}
