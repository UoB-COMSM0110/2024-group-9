Star[] stars = new Star[950];
PFont customFont1;
boolean gameStarted = false;

boolean characterChosen = false;
int selectedCharacter = 0;

boolean nameSelected = false;
String userName = "";


void setup() {
  size(1200, 900);
  background(0);
  customFont1 = createFont("Impossible - 1000", 48);
  textFont(customFont1);
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
}

void draw() {
  background(0);
    if(!gameStarted) {
      displayStartScreen();
    } else if (gameStarted && !characterChosen){
       displayChooseCharacter();
    } else if (characterChosen && !nameSelected) {
      enterNameScreen();
    } else {
      //enter the game (at a later date of course)
    }
         
    translate(width / 2, height / 2);
    for (int i = 0; i < stars.length; i++) {
      stars[i].update();
      stars[i].show();
  }
}

void displayStartScreen() {
  fill(200, 20, 0);
  textAlign(CENTER, CENTER);
  textSize(90);
  text("MISSION: POSSIBLE", width/2, height/2);
  fill(255); 
  textAlign(LEFT, BOTTOM); 
  float mainTextX = width / 2 - 400;
  float mainTextY = height / 2 - 35; 
  textSize(30);
  text("GROUP 09", mainTextX, mainTextY);
  fill(128, 128, 128);
  textAlign(CENTER, CENTER);
  textSize(30);
  text("PRESS ANY KEY TO BEGIN", width/2, height/2 + 120);
}  

void displayChooseCharacter() {
  fill(200, 20, 0);
  textAlign(CENTER, CENTER);
  textSize(80);
  text("CHOOSE YOUR", width/2, 105);
  text("CHARACTER", width/2, 185);
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
  text("ENTER YOUR NAME:", width/2, 105);
  fill(255);
  textSize(95);
  text(userName, width/2 - 40, 400);
  
}
  
void keyPressed() {
  if(!gameStarted) {
    gameStarted = true;
  } else if (!nameSelected) {
    if (key == BACKSPACE) {
      if (userName.length() > 0) {
        userName = userName.substring(0, userName.length() - 1);
      }
    } else if (key == ENTER || key == RETURN) {
      nameSelected = true;
    } else {
      userName += key;
    }
  }
}

void mouseClicked() {
  if(!gameStarted){  
  } else if (gameStarted && !characterChosen) {
      if(mouseX >= 150 && mouseX <=310 && mouseY >= 300 && mouseY <= 460) {
        characterChosen = true;
        selectedCharacter = 1;
      } else if(mouseX >= 520 && mouseX <=680 && mouseY >= 300 && mouseY <= 460) {
        characterChosen = true;
        selectedCharacter = 2;
      } else if(mouseX >= 890 && mouseX <=1050 && mouseY >= 300 && mouseY <= 460) {
        characterChosen = true;
        selectedCharacter = 3;
      } else if(mouseX >= 335 && mouseX <=495 && mouseY >= 560 && mouseY <= 720) {
        characterChosen = true;
        selectedCharacter = 4;
      } else if(mouseX >= 705 && mouseX <=865 && mouseY >= 560 && mouseY <= 720) {
        characterChosen = true;
        selectedCharacter = 5;
      }
  }
}
