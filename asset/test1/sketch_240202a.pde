import gifAnimation.*;

boolean gameTitleScreen = true; // 用于跟踪是否在游戏开始界面
boolean gameHeroSelectionScreen = false; // 用于跟踪是否在选择英雄界面
boolean heroconfirm  = false;


int buttonX = 300; // 按钮左上角X坐标
int buttonY = 300; // 按钮左上角Y坐标
int buttonWidth = 200; // 按钮宽度
int buttonHeight = 50; // 按钮高度

Gif playerImage; // 声明一个PImage对象用于存储角色图像
Gif walkAnimation; // 用于行走的GIF动画
Gif jumpAnimation; // 用于跳跃的GIF动画
Gif attackAnimation; // 用于攻击的GIF动画

boolean isWalking = false; // 用于跟踪角色是否正在行走
boolean isFacingRight = true; // 用于跟踪人物面朝方向
boolean isAttacking = false; // 用于跟踪角色是否正在攻击

PImage backgroundImage; // 声明一个PImage变量来存储背景图像

  int heroButtonX = 100;
  int heroButtonY = height/2;
  int heroButtonWidth = 100;
  int heroButtonHeight = 100;

void setup() {
  size(800, 400); // 设置窗口大小
  background(255); // 设置背景颜色（白色）
  
  playerImage = new Gif(this, "gothic-hero-idle.gif"); // 加载角色图像
  walkAnimation = new Gif(this, "gothic-hero-run.gif");
  jumpAnimation = new Gif(this, "gothic-hero-jump.gif"); // 加载跳跃动画
  attackAnimation = new Gif(this, "gothic-hero-attack.gif"); // 加载攻击动画
  
  backgroundImage = loadImage("background.jpg"); // 加载背景图像
  
}

// 确定按钮的位置信息
int confirmButtonX;
int confirmButtonY;
int confirmButtonWidth = 100;
int confirmButtonHeight = 50;
  
void drawHeroSelectionScreen() {
  // 清空背景
  background(0);
  
  // 绘制选择英雄界面
  fill(255);
  textSize(40);
  textAlign(CENTER, CENTER);
  text("Choose Your Hero", width/2, height/3);
  
  // 绘制4个英雄按钮
  int numHeroes = 4;
  int heroButtonSpacing = 20; // 英雄按钮之间的间距
  int heroButtonWidth = 100; // 英雄按钮宽度
  int heroButtonHeight = 100; // 英雄按钮高度
  int totalWidth = numHeroes * heroButtonWidth + (numHeroes - 1) * heroButtonSpacing; // 所有按钮总宽度
  int startX = (width - totalWidth) / 2; // 第一个按钮的起始X坐标
  
  for (int i = 0; i < numHeroes; i++) {
    int heroButtonX = startX + i * (heroButtonWidth + heroButtonSpacing); // 计算按钮的X坐标
    int heroButtonY = height/2; // 按钮的Y坐标，这里假设所有按钮都在屏幕中央
    // 绘制按钮
    fill(255, 0, 0);
    rect(heroButtonX, heroButtonY, heroButtonWidth, heroButtonHeight);
    // 绘制其他英雄按钮...
  }
  
    // 初始化确认按钮位置信息
  confirmButtonX = width / 2 - 50;
  confirmButtonY = height * 5 / 6;
  
  fill(0, 255, 0);
  rect(confirmButtonX, confirmButtonY, confirmButtonWidth, confirmButtonHeight);
  fill(255);
  textSize(20);
  textAlign(CENTER, CENTER);
  text("Confirm", width / 2, confirmButtonY + confirmButtonHeight / 2); // 将文字位置设置为按钮中心

}

void drawTitleScreen() {
  background(0); // 设置开始界面的背景色为黑色
  fill(255); // 设置文字颜色为白色
  textSize(40); // 设置文字大小
  textAlign(CENTER, CENTER); // 设置文字居中对齐
  text("Fruit World", width/2, height/3); // 绘制游戏名字
  
  // 绘制开始按钮
  fill(255, 0, 0); // 设置按钮颜色为红色
  rect(buttonX, buttonY, buttonWidth, buttonHeight); // 绘制按钮
  fill(255); // 设置按钮文字颜色为白色
  textSize(20); // 设置按钮文字大小
  textAlign(CENTER, CENTER); // 设置按钮文字居中对齐
  text("Start Game", buttonX + buttonWidth/2, buttonY + buttonHeight/2); // 绘制按钮文字
}

float playerX = 50; // 玩家初始X位置
float playerY = 300; // 玩家初始Y位置

float playerWidth = 30; // 玩家宽度
float playerHeight = 50; // 玩家高度

float playerSpeedX = 0; // 玩家水平速度
float playerSpeedY = 0; // 玩家垂直速度
float acceleration = 0.2; // 玩家水平加速度
float jumpStrength = -10; // 初始跳跃力
boolean isJumping = false; // 玩家是否正在跳跃
long jumpStartTime = 0; // 记录跳跃开始时间


void drawBackground() {
  image(backgroundImage, 0, 0, width, height); // 绘制背景图像，覆盖整个窗口
}

void drawPlayer() {
  pushMatrix(); // 保存当前的绘图矩阵状态
  translate(playerX + playerWidth / 2, playerY + playerHeight / 2); // 将坐标原点移到人物中心
  if (isFacingRight) {
    // 如果人物面朝右边，则不进行翻转
    if (isWalking && playerY == height - playerHeight ) {
      walkAnimation.play();
      image(walkAnimation, -playerWidth / 2, -playerHeight / 2, playerWidth, playerHeight);
    } else if (isJumping) {
      jumpAnimation.play();
      image(jumpAnimation, -playerWidth / 2, -playerHeight / 2, playerWidth*1.3, playerHeight*1.7);
      
    } else if (isAttacking) {
      attackAnimation.play();
      image(attackAnimation, -playerWidth / 2, -playerHeight / 2, playerWidth*1.7, playerHeight);
    } else {
      playerImage.play();
      image(playerImage, -playerWidth / 2, -playerHeight / 2, playerWidth, playerHeight);
    }
  } else {
    // 如果人物面朝左边，翻转图像
    if (isWalking && playerY == height - playerHeight) {  
      walkAnimation.play();
      scale(-1, 1); // 沿X轴翻转图像
      image(walkAnimation, -playerWidth / 2, -playerHeight / 2, playerWidth, playerHeight);
    } else if (isJumping) {
      jumpAnimation.play();
      scale(-1, 1); // 沿X轴翻转图像
      image(jumpAnimation, -playerWidth / 2, -playerHeight / 2, playerWidth*1.3, playerHeight*1.7);
      
    } else if (isAttacking) {
      attackAnimation.play();
      scale(-1, 1); // 沿X轴翻转图像
      image(attackAnimation, -playerWidth / 2, -playerHeight / 2, playerWidth*1.7, playerHeight);
    } else {
      playerImage.play();
      scale(-1, 1); // 沿X轴翻转图像
      image(playerImage, -playerWidth / 2, -playerHeight / 2, playerWidth, playerHeight);
    }
  }
  popMatrix(); // 恢复绘图矩阵状态
}


float playerSpeed = 5; // 玩家移动速度
float gravity = 0.2; // 重力

void updatePlayer() {
  playerX += playerSpeedX; // 更新玩家水平位置

  // 限制玩家不超出屏幕边界
  playerX = constrain(playerX, 0, width - playerWidth);

  playerY += playerSpeedY; // 更新玩家垂直位置
  playerSpeedY += acceleration; // 增加垂直速度（重力效果）

  // 限制玩家不掉出屏幕底部
  if (playerY >= height - playerHeight) {
    playerY = height - playerHeight;
    playerSpeedY = 0;
    // 玩家在地面上时停止跳跃
    isJumping = false;
  }
}

void draw() {
  if (gameTitleScreen) {
    drawTitleScreen(); // 绘制游戏开始界面
  } else if (gameHeroSelectionScreen) {
    drawHeroSelectionScreen(); // 绘制选择英雄界面
  } else if ( heroconfirm ) {
    background(255); // 清空背景
    drawBackground();
    drawPlayer();
    updatePlayer();
    // 绘制和更新障碍物
  }
}

void keyPressed() {
  if (key == ' ' && playerY == height - playerHeight) {
    playerSpeedY = -7; // 玩家跳跃
    isJumping = true; // 玩家正在跳跃
  }
  
  if (key == 'A' || key == 'a') {
    isAttacking = true; // 玩家正在攻击
    // 执行攻击动作的代码
  }
  
  if (key == CODED) {
    if (keyCode == LEFT) {
      isWalking = true; // 玩家正在行走
      isFacingRight = false; // 人物面朝左
      playerSpeedX = -5; // 向左移动
    } else if (keyCode == RIGHT) {
      isWalking = true; // 玩家正在行走
      isFacingRight = true; // 人物面朝右
      playerSpeedX = 5; // 向右移动
    }
  }
}

void mousePressed() {
  if (gameTitleScreen) {
    // 如果游戏处于开始界面，检查开始按钮
    if (mouseX >= buttonX && mouseX <= buttonX + buttonWidth && mouseY >= buttonY && mouseY <= buttonY + buttonHeight) {
      // 如果点击了开始按钮，进入选择英 雄界面
      gameTitleScreen = false;
      gameHeroSelectionScreen = true;
    }
  } else if (gameHeroSelectionScreen) {
    // 如果游戏处于选择英雄界面
    // 检查点击的是哪个英雄按钮
    if (mouseX >= heroButtonX && mouseX <= heroButtonX + heroButtonWidth && mouseY >= heroButtonY && mouseY <= heroButtonY + heroButtonHeight) {
      // 玩家选择了第一个英雄
      // 执行相应的处理...
    } else if (mouseX >= heroButtonX + heroButtonWidth + 20 && mouseX <= heroButtonX + 2 * heroButtonWidth + 20 && mouseY >= heroButtonY && mouseY <= heroButtonY + heroButtonHeight) {
      // 玩家选择了第二个英雄
      // 执行相应的处理...
    } else if (mouseX >= heroButtonX + 2 * (heroButtonWidth + 20) && mouseX <= heroButtonX + 3 * heroButtonWidth + 40 && mouseY >= heroButtonY && mouseY <= heroButtonY + heroButtonHeight) {
      // 玩家选择了第三个英雄
      // 执行相应的处理...
    } else if (mouseX >= heroButtonX + 3 * (heroButtonWidth + 20) && mouseX <= heroButtonX + 4 * heroButtonWidth + 60 && mouseY >= heroButtonY && mouseY <= heroButtonY + heroButtonHeight) {
      // 玩家选择了第四个英雄
      // 执行相应的处理...
    } else if (mouseX >= confirmButtonX && mouseX <= confirmButtonX + confirmButtonWidth && mouseY >= confirmButtonY && mouseY <= confirmButtonY + confirmButtonHeight) {
      // 点击了确认按钮，进入游戏
      gameHeroSelectionScreen = false;
      heroconfirm = true;
    }
  }
}


void keyReleased() {
  if (key == CODED) {
    if (keyCode == LEFT || keyCode == RIGHT) {
      isWalking = false; // 玩家停止行走
      playerSpeedX = 0; // 停止水平移动
    }
  }
  if (key == 'A' || key == 'a') {
    isAttacking = false; // 玩家停止攻击
    // 停止攻击动作的代码
  }

  
}
