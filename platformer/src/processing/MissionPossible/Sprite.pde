public abstract class Sprite{
  int xPos;
  int yPos;
  float speed;
  float yAcceleration;
  float xAcceleration;
  float xSpeed;
  float ySpeed;
  int spriteWidth;
  int spriteHeight;
  int spriteLayer;
  float health; // Move to PlayerControlledSprite if only player has health
  float damage;
  boolean onGround;
  boolean collision;
  PImage image;
  String shape;
  
  public Sprite(int xPos, int yPos, int spriteWidth, int spriteHeight, int spriteLayer, String shape) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.spriteWidth = spriteWidth;
    this.spriteHeight = spriteHeight;
    this.spriteLayer = spriteLayer;
    this.shape = shape;
  }
}
