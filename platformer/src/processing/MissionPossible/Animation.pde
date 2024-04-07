import java.util.ArrayList;
import java.util.LinkedHashMap;

class Animation {
    private ArrayList<ImageData> images;
    private String spriteName;
    private String animationName;
    private int nextFrameNum;
    private float lastFrameTime;

    public Animation(String spriteName, String animationName) {
        this.spriteName = spriteName;
        this.animationName = animationName;
        this.images = new ArrayList<ImageData>();
        this.nextFrameNum = 0;
        this.lastFrameTime = 0;
        JSONArray info = loadJSONArray(dataPath(spriteName + File.separator + animationName + File.separator + "info.json"));
        for (int i = 0; i < info.size(); i++) {
            JSONObject frameInfo = info.getJSONObject(i);
            String frameFileName = frameInfo.getString("filename");
            float delay = frameInfo.getFloat("delay");
            PImage image = loadImage(dataPath(spriteName + File.separator + animationName + File.separator + frameFileName));
            images.add(new ImageData(image, delay));
        }
    }
    
    public PImage nextFrame(float speed) {
      if (speed < 0f) {
        speed *= -1f;
      }
      if (speed < 1f) {
        speed = 1f;
      }
      float currentTime = (float) millis();
      if (currentTime - lastFrameTime > this.images.get(nextFrameNum).getDelay() / speed) {
        nextFrameNum++;
        lastFrameTime = currentTime;
      }
      if (nextFrameNum >= this.images.size()) {
        nextFrameNum = 0;
      }
      return this.images.get(nextFrameNum).getImage();
    }

}
