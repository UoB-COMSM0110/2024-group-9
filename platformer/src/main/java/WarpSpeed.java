package main.java;


import processing.core.PApplet;

public class WarpSpeed {
    public static class Star {
        private final PApplet parent;
        float x;
        float y;
        float z;
        float pz;
        private float width;
        private float height;


        Star(PApplet parent, float width, float height) {
            this.parent = parent;
            this.width = width;
            this.height = height;
            x = parent.random(-width, width);
            y = parent.random(-height, height);
            z = parent.random(width);
            pz = z;
        }

        public void update() {
            pz = z;
            z = z - 18;
            if(z<1){
                z = this.width;
                x = parent.random(-width, width);
                y = parent.random(-height, height);
                pz = z;
            }
        }

        public void show() {
            parent.fill(255);
            parent.noStroke();

            float sx = PApplet.map(x/z, 0, 1, 0, width);
            float sy = PApplet.map(y/z, 0, 1, 0, height);
            float r = PApplet.map(z, 0, width, 16, 0);

            float px = PApplet.map(x/pz, 0, 1, 0, width);
            float py = PApplet.map(y/pz, 0, 1, 0, height);

            parent.stroke(255);
            parent.line(px, py, sx, sy);

            //ellipse(sx,sy,r,r);
        }
    }

}
