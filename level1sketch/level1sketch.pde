void setup(){
  size(2000, 1200);
  background(0);
}

void draw(){

  // Ground
  rect(0, height-100, width, 100); //
  
  // Platforms
  rect(200, height-200, 100, 20); //
  rect(500, height-250, 150, 20); //
  rect(750, height-300, 120, 200); //
  rect(1000, height-400, 130, 20); //
  rect(1100, height-300, 100, 20); //
  rect(1400, height-350, 100, 20); //
  rect(1600, height-500, 400, 20); //
  
  // Enemy
  rect(1800, height-535, 35, 35);
}
