package main.java;

import processing.core.PApplet;

import java.awt.*;

public class View {
    private final PApplet parent;
    float height;
    float width;

    View(PApplet parent) {
        this.parent = parent;
        Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
        this.width = (float) screenSize.getWidth();
        this.height = (float) screenSize.getHeight();
    }

    public float getHeight() {
        return height;
    }

    public float getWidth() {
        return width;
    }
}
