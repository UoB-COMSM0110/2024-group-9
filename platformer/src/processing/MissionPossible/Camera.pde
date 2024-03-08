public class Camera {
    private float xPos;
    private float yPos;

    Camera(float xPos, float yPos) {
        setPos(xPos, yPos);
    }

    public float getXPos() {
        return xPos;
    }

    public float getYPos() {
        return yPos;
    }

    public float[] getPos() {
        return new float[]{getXPos(), getYPos()};
    }

    public void setPos(float xPos, float yPos) {
        this.xPos = xPos;
        this.yPos = yPos;
    }
}
