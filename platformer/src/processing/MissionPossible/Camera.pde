public class Camera {
    private int xPos;
    private int yPos;

    Camera(int xPos, int yPos) {
        setPos(xPos, yPos);
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
        this.xPos = xPos;
        this.yPos = yPos;
    }
}
