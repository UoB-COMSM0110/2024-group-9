
GameState game = new GameState();
Star[] stars = new Star[950];
View currentView;
  int pos = 10;
PFont MPFont;


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
  
}

void draw() {
  background(0);
  currentView.displayView();

  //  if(!game.started) {
  //    displayStartScreen();
  //  } else if (game.started && !game.characterChosen){
  //     displayChooseCharacter();
  //  } else if (game.characterChosen && !game.nameSelected) {
  //    enterNameScreen();
  //  } else {
  //    // Temporary - replace with entering game 
  //    text("Welcome " + game.playerNickname + "!", displayWidth/2, displayHeight/2);
  //    //enter the game (at a later date of course)
  //  }
         
  //  translate(displayWidth / 2, displayHeight / 2);
  //  for (int i = 0; i < stars.length; i++) {
  //    stars[i].update();
  //    stars[i].show();
  //}
}

void displayStartScreen() {
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
  fill(200, 20, 0);
  textAlign(CENTER, CENTER);
  textSize(80);
  text("CHOOSE YOUR", displayWidth/2, 105);
  text("CHARACTER", displayWidth/2, 185);
  noFill();
  square(150, 300, 160);
  square(520, 300, 160);
  square(890, 300, 160);
  square(335, 560, 160);
  square(705, 560, 160);
  fill(200,20,0);
  textSize(25);
  text("EXAMPLE", 230, 380);
}

void enterNameScreen() {
  fill(200, 20, 0);
  textAlign(CENTER, CENTER);
  textSize(80);
  text("ENTER YOUR NAME:", displayWidth/2, 105);
  fill(255);
  textSize(95);
  text(game.playerNickname, displayWidth/2 - 40, 400);
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
  if(!game.started){  
  } else if (game.started && !game.characterChosen) {
      if(mouseX >= 150 && mouseX <=310 && mouseY >= 300 && mouseY <= 460) {
        game.characterChosen = true;
        game.playerCharacter = CharacterVariant.SPACEMAN;
      } else if(mouseX >= 520 && mouseX <=680 && mouseY >= 300 && mouseY <= 460) {
        game.characterChosen = true;
        game.playerCharacter = CharacterVariant.COWBOY;
      } else if(mouseX >= 890 && mouseX <=1050 && mouseY >= 300 && mouseY <= 460) {
        game.characterChosen = true;
        game.playerCharacter = CharacterVariant.SPONGEBOB;
      } else if(mouseX >= 335 && mouseX <=495 && mouseY >= 560 && mouseY <= 720) {
        game.characterChosen = true;
        game.playerCharacter = CharacterVariant.CAT;
      } else if(mouseX >= 705 && mouseX <=865 && mouseY >= 560 && mouseY <= 720) {
        game.characterChosen = true;
        game.playerCharacter = CharacterVariant.SKELETON;
      }
  }
}
