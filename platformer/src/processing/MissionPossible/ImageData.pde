class ImageData {
    private PImage image;
    private float delay;

    public ImageData(PImage image, float delay) {
        this.image = image;
        this.delay = delay;
    }

    public PImage getImage() {
        return image;
    }

    public float getDelay() {
        return delay;
    }
}
