package main.java;

import processing.core.PApplet;

import java.awt.*;

public class View {
    private final PApplet parent;
    double height;
    double width;

    View(PApplet parent) {
        this.parent = parent;
        Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
        this.width = screenSize.getWidth();
        this.height = screenSize.getHeight();
    }

    public double getHeight() {
        return height;
    }

    public double getWidth() {
        return width;
    }
}
