PImage gameMapImage;
float cameraX = 0;
float scaleFactor = 2; // 放大系数

void setup() {
  size(600, 352);
  gameMapImage = loadImage("asset/map/NinjaGaiden-ActI-Scenes1&2(Unmarked).png");
}

void draw() {
  background(0);
  
  // 设置相机位置
  translate(-cameraX, 0);
  
  // 计算放大后的宽度和高度
  float scaledWidth = gameMapImage.width * scaleFactor;
  float scaledHeight = gameMapImage.height * scaleFactor;
  
  // 绘制放大后的地图
  image(gameMapImage, 0, 0, scaledWidth, scaledHeight);
  
  // 显示人物，假设人物位置为相机位置
  fill(255, 0, 0);
  ellipse(constrain(cameraX + width / 2, 0, gameMapImage.width - width), height / 2, 20, 20);
}

void frameResized() {
  // 当窗口大小改变时，重新计算放大系数
  scaleFactor = min(float(width) / gameMapImage.width, float(height) / gameMapImage.height);
}

void keyPressed() {
  if (keyCode == LEFT) {
    // 向左移动相机
    cameraX -= 10;
  } else if (keyCode == RIGHT) {
    // 向右移动相机
    cameraX += 10;
  }
  // 确保相机不超出地图边界
  cameraX = constrain(cameraX, 0, gameMapImage.width - width);
}
