package main.java;

import processing.core.PApplet;

import java.awt.*;

public class View {
    private final PApplet parent;
    float height;
    float width;
    private final Camera camera;

    View(PApplet parent) {
        this.parent = parent;
        Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
        this.width = (float) screenSize.getWidth();
        this.height = (float) screenSize.getHeight();
        this.camera = new Camera(this.parent, this.width / 2, this.height / 2);
    }

    public float getHeight() {
        return height;
    }

    public float getWidth() {
        return width;
    }
}
