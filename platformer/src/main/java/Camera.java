package main.java;

import processing.core.PApplet;

public class Camera {
    private final PApplet parent;
    private float xPos;
    private float yPos;

    Camera(PApplet parent, float xPos, float yPos) {
        this.parent = parent;
        this.xPos = xPos;
        this.yPos = yPos;
    }

    public float getxPos() {
        return xPos;
    }

    public float getyPos() {
        return yPos;
    }

    public float[] getPos() {
        return new float[]{getxPos(), getyPos()};
    }

    public void setPos(float xPos, float yPos) {
        this.xPos = xPos;
        this.yPos = yPos;
    }
}
