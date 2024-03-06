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
  
  public Sprite(){}
}
