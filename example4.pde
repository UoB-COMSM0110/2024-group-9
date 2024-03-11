int startTime = 0;
// Define the obstacle object
public class Obstacle {
  float x, y, width, height;
  
  Obstacle(float x, float y, float width, float height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }
  
  void display() {
    // Display the obstacle
    fill(150);
    rect(x, y, width, height);
  }
}

// Define the player object
public class Player {
  float x, y; // Player position
  float velocityY; // Y-direction velocity
  float gravity; // Gravity
  float jumpForce; // Jump force
  float playerSpeed; // Player speed
  float playerWidth = 40; // Player width
  float playerHeight = 40; // Player height
  boolean movingLeft, movingRight, dashLeft, dashRight; // Flag to indicate player movement direction
  boolean isGround = true; // Flag to indicate if player is on the ground
  boolean faceToLeft = true;
  
  Player(float x, float y, float gravity, float jumpForce, float playerSpeed) {
    this.x = x;
    this.y = y;
    this.gravity = gravity;
    this.jumpForce = jumpForce; 
    this.playerSpeed = playerSpeed; 
  }
  
  void update(Obstacle[] obstacles) {
    // Update player position based on movement direction
    if (movingLeft && !dashLeft && !dashRight) {
      if (checkCollision(obstacles, x - playerSpeed, y, playerWidth, playerHeight) == false) {//next step no collision check collision with obstacles for x
        x -= playerSpeed;
      }
    }
    if (movingRight && !dashLeft && !dashRight) {
      if (checkCollision(obstacles, x + playerSpeed, y,  playerWidth, playerHeight) == false) {//next step no collision check collision with obstacles for x
        x += playerSpeed;
      }
    }
    if(dashLeft) {
      if(millis() - startTime <= 200){
        x -= 20;
      }
      else{
        dashLeft = false;
      }
    }
    if(dashRight) {
      if(millis() - startTime <= 200){
        x += 20;
      }
      else{
        dashRight = false;
      }
    }
    
    // Apply gravity
    velocityY += gravity;
    y += velocityY;
    
    // Collision detection: Stop descending if player touches the grpund
    if (y + playerHeight > height) {
      y = height - playerHeight;
      velocityY = 0;
      isGround = true;
    }
   
    
    // Check collision with obstacles for y
  for (Obstacle obstacle : obstacles) {
    if (x + playerWidth > obstacle.x && x < obstacle.x + obstacle.width && y + playerHeight > obstacle.y && y < obstacle.y + obstacle.height) {
      // Player collided with obstacle
      if (velocityY > 0 && y <= obstacle.y) {//玩家上边界高于障碍物上边界
        // Player is descending, stop at the top of the obstacle
        y = obstacle.y - playerHeight;
        velocityY = 0;
        isGround = true;
      } else if (velocityY < 0 && y + playerHeight > obstacle.y) {
        // Player is jumping and collides with obstacle above, stop upward velocity
        velocityY = 0;
        y = obstacle.y + obstacle.height;
      }
    }
  }
}
  
 boolean checkCollision(Obstacle[] obstacles, float px, float py, float pw, float ph) {
  for (Obstacle obstacle : obstacles) {
    if (px + pw > obstacle.x && px < obstacle.x + obstacle.width && py + ph > obstacle.y && py < obstacle.y + obstacle.height) {
      return true; // Collision detected
    }
  }
  return false; // No collision detected
  }
  
  void jump() {
    // Player jumps upward if on the ground
    if (isGround) {
      velocityY = -jumpForce;
      isGround = false;
    }
  }
  
  void display() {
    // Display the player
    fill(255);
    rect(x, y, playerWidth, playerHeight);
  }
}

Player player; // Player object
Obstacle[] obstacles; // Array to hold obstacles
public float gravity = 0.7; // Gravity acceleration
float jumpForce = 16; // Jump force
float playerSpeed = 5; // Player movement speed

void setup() {
  size(900, 500);
  
  // Initialize player
  player = new Player(width/2, height/2, gravity, jumpForce, playerSpeed);
  
  // Initialize obstacles
  obstacles = new Obstacle[4];
  obstacles[0] = new Obstacle(200, height - 100, 100, 20);
  obstacles[1] = new Obstacle(500, height - 150, 150, 20);
  obstacles[2] = new Obstacle(750, height - 200, 120, 20);
  obstacles[3] = new Obstacle(750, height - 200, 120, 200);
}

void draw() {
  background(0);
  
  // Draw obstacles
  for (Obstacle obstacle : obstacles) {
    obstacle.display();
  }
  
  // Update and display the player
  player.update(obstacles);
  player.display();
}

void keyPressed() {
  if (key == ' ' || keyCode == UP) { // Space key to jump
    player.jump();
  } else if (keyCode == LEFT || key == 'a' || key == 'A') { // Left arrow or A key to move left
    player.movingLeft = true;
    player.faceToLeft = true;
  } else if (keyCode == RIGHT || key == 'd' || key == 'D') { // Right arrow or D key to move right
    player.movingRight = true;
    player.faceToLeft = false;
  } else if (keyCode == CONTROL){
    startTime = millis();
      if(player.faceToLeft == true){
        player.dashLeft = true;
      }
      else{
        player.dashRight = true;
      }
  }
}

void keyReleased() {
  if (keyCode == LEFT || key == 'a' || key == 'A') { // Left arrow or A key released, stop moving left
    player.movingLeft = false;
  } else if (keyCode == RIGHT || key == 'd' || key == 'D') { // Right arrow or D key released, stop moving right
    player.movingRight = false;
  }
}
