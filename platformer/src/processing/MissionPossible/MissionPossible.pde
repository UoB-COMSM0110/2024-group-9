
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
  /*print(mouseX, mouseY, "\n");
  print(displayWidth/6, displayWidth/6 + boxWH, "\n");*/

  if(!game.started) {
    displayStartScreen();
  } 
  else if (!game.characterChosen){
       displayChooseCharacter();
  } 
  else if (game.characterChosen && !game.nameSelected) {
      enterNameScreen();
  } 
  else if (game.tutorialChosen == false) {
    tutorialScreen();
  }
  else if(game.mode == null){
    modeScreen();
  } 
  else {
    currentView.displayView();
  }
         
  translate(displayWidth / 2, displayHeight / 2);
  for (int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].show();
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

void displayChooseCharacter() {
  game.section = SectionVariant.CHOOSECHARACTER;
  fill(200, 20, 0);
  textAlign(CENTER, CENTER);
  textSize(80);
  text("CHOOSE YOUR CHARACTER", displayWidth/2, displayHeight/6);
  fill(0);
  square(displayWidth/6, displayHeight/3.5, boxWH);
  square(displayWidth/2 - (boxWH/2), displayHeight/3.5, boxWH);
  square(displayWidth - (displayWidth/6) - boxWH, displayHeight/3.5, boxWH);
  square(displayWidth/6, displayHeight/1.5, boxWH);
  square(displayWidth/2 - (boxWH/2), displayHeight/1.5, boxWH);
  square(displayWidth - (displayWidth/6) - boxWH, displayHeight/1.5, boxWH);
  fill(200,20,0);
}

void enterNameScreen() {
  game.section = SectionVariant.ENTERNAME;
  fill(200, 20, 0);
  textAlign(CENTER, CENTER);
  textSize(80);
  text("ENTER YOUR NAME:", displayWidth/2, 105);
  fill(255);
  textSize(95);
  text(game.playerNickname, displayWidth/2 - 40, 400);
}

void tutorialScreen(){
  game.section = SectionVariant.CHOOSETUTORIAL;
  fill(200, 20, 0);
  textAlign(CENTER, CENTER);
  textSize(80);
  text("Welcome " + game.playerNickname + "!", displayWidth/2, displayHeight/5);
  fill(255);
  text("Play tutorial?", displayWidth/2, displayHeight/3);
  noFill();
  square(displayWidth/4, displayHeight/2, boxWH);
  square(displayWidth - (displayWidth/4) - boxWH, displayHeight/2, boxWH);
  textSize(40);
  text("Yes", (displayWidth/4)+(boxWH/2), (displayHeight/2)+(boxWH/2));
  text("No", displayWidth - (displayWidth/4) - (boxWH/2), (displayHeight/2)+(boxWH/2));
}

void modeScreen(){
  game.section = SectionVariant.CHOOSEDIFFICULTY;
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(80);
  text("Choose difficulty", displayWidth/2, displayHeight/4);
  noFill();
  square(displayWidth/4, displayHeight/2, boxWH);
  square(displayWidth - (displayWidth/4) - boxWH, displayHeight/2, boxWH);
  textSize(30);
  text("Easy", (displayWidth/4)+(boxWH/2), (displayHeight/2)+(boxWH/2));
  text("Difficult", displayWidth - (displayWidth/4) - (boxWH/2), (displayHeight/2)+(boxWH/2));

}
  
void keyPressed() {
  if(!game.started) {
    game.started = true;
  } else if (!game.nameSelected) {
    if (key == BACKSPACE) {
      if (game.playerNickname.length() > 0) {
        game.playerNickname = game.playerNickname.substring(0, game.playerNickname.length() - 1);
      }
    } else if (key == ENTER || key == RETURN) {
      game.nameSelected = true;
    } else {
      game.playerNickname += key;
    }
  }
}

void mouseClicked() {
if (game.section == SectionVariant.CHOOSECHARACTER) {
      if(mouseX >= displayWidth/6 && mouseX <=(displayWidth/6)+boxWH && mouseY >= displayHeight/3.5 && mouseY <= (displayHeight/3.5)+boxWH) {
        game.characterChosen = true;
        game.playerCharacter = CharacterVariant.SPACEMAN;
      } else if(mouseX >= (displayWidth/2)-(boxWH/2) && mouseX <=(displayWidth/2)+(boxWH/2) && mouseY >= displayHeight/3.5 && mouseY <= (displayHeight/3.5)+boxWH) {
        game.characterChosen = true;
        game.playerCharacter = CharacterVariant.COWBOY;
      } else if(mouseX >= (displayWidth - (displayWidth/6) - boxWH) && mouseX <= displayWidth - (displayWidth/6) && mouseY >= displayHeight/3.5 && mouseY <= (displayHeight/3.5)+boxWH) {
        game.characterChosen = true;
        game.playerCharacter = CharacterVariant.SPONGEBOB;
      } else if(mouseX >=displayWidth/6 && mouseX <=(displayWidth/6)+boxWH && mouseY >= displayHeight/1.5 && mouseY <= (displayHeight/1.5)+boxWH) {
        game.characterChosen = true;
        game.playerCharacter = CharacterVariant.CAT;
      } else if(mouseX >= (displayWidth/2)-(boxWH/2) && mouseX <=(displayWidth/2)+(boxWH/2) && mouseY >= displayHeight/1.5 && mouseY <= (displayHeight/1.5)+boxWH) {
        game.characterChosen = true;
        game.playerCharacter = CharacterVariant.SKELETON;
      } else if(mouseX >= (displayWidth - (displayWidth/6) - boxWH) && mouseX <= displayWidth - (displayWidth/6) && mouseY >= displayHeight/1.5 && mouseY <= (displayHeight/1.5)+boxWH){
        game.characterChosen = true;
        game.playerCharacter = CharacterVariant.DOG;
      }
     
  }
  
  else if (game.section == SectionVariant.CHOOSETUTORIAL){
  
  }
  
  else if (game.section == SectionVariant.CHOOSEDIFFICULTY){
  
  }
}
