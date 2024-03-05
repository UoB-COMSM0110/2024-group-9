public abstract class Sprite{
  int xPos;
  int yPos;
  float speed;
  float yAcceleration;
  float xAcceleration;
  int spriteWidth;
  int spriteHeight;
  int spriteLayer;
  int health; // Move to PlayerControlledSprite if only player has health
  boolean onGround;
  PImage image;
  // TODO direction - type?
  // TODO damage - type?
  // TODO collision - type?
  
  public Sprite(){}
}
