package main.java;

import processing.core.PApplet;

public class Camera {
    private final PApplet parent;
    private float xPos;
    private float yPos;

    Camera(PApplet parent, float xPos, float yPos) {
        this.parent = parent;
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
