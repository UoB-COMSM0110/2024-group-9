public class Camera {
    private int levelWidth;
    private int levelHeight;
    private int xPos;
    private int yPos;

    Camera(int levelWidth, int levelHeight) {
      this.levelWidth = levelWidth;
      this.levelHeight = levelHeight;
    }

    public int getXPos() {
        return xPos;
    }

    public int getYPos() {
        return yPos;
    }

    public int[] getPos() {
        return new int[]{getXPos(), getYPos()};
    }

    public void setPos(int xPos, int yPos) {
        this.xPos = constrain(xPos, 0, levelWidth - displayWidth);
        this.yPos = constrain(yPos, 0, levelHeight - displayHeight);
    }
}
