PImage bg,cabbage,gameover,life,soil,soldier;
PImage groundhogDown,groundhogIdle,groundhogLeft,groundhogRight;
PImage title,startHovered,startNormal,restartHovered,restartNormal;

final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_WIN = 2;
final int GAME_OVER = 3;

int state = GAME_START;
       
boolean uppressed = false;
boolean downpressed = false;
boolean leftpressed = false;
boolean rightpressed = false;

//soldier
int soldierX = 0;
int soldierSpeed = 3;
int soldierY = floor(random(2,6))*80;
int soldierWidth = 80;

//cabbage
int cabbageX = floor(random(1,8))*80;
int cabbageY = floor(random(2,6))*80;
int cabbageWidth = 80;

//control
final int BOTTOM_LEFT = 248;
final int BOTTOM_RIGHT = 392;
final int BOTTOM_UP = 360;
final int BOTTOM_DOWN = 420;

int groundhogIdleX,groundhogIdleY = 80;
int groundhogSpeed = 0;
int groundhogWidth = 80;

final int LIFE_GAP = 20;
final int LIFE_WIDTH = 50;

int lifeX = 10;
int lifeY = 10;

void setup() {
	size(640, 480, P2D);
	// Enter Your Setup Code Here
  frameRate(60);
  bg = loadImage("img/bg.jpg");
  cabbage = loadImage("img/cabbage.png");
  gameover = loadImage("img/gameover.jpg");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  life = loadImage("img/life.png");
  restartHovered = loadImage("img/restartHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  soil = loadImage("img/soil.png");
  soldier = loadImage("img/soldier.png");
  startHovered = loadImage("img/startHovered.png");
  startNormal = loadImage("img/startNormal.png");
  title = loadImage("img/title.jpg");
  
  groundhogIdleX = width/2;
  groundhogIdleY = height/6;
}

void draw() {
    // Switch Game State
    // Game Start
    switch(state){
      case GAME_START:
      image(title,0,0);
      if(mouseX > BOTTOM_LEFT && mouseX < BOTTOM_RIGHT
      && mouseY > BOTTOM_UP && mouseY < BOTTOM_DOWN){
        image(startHovered,BOTTOM_LEFT,BOTTOM_UP);
        if(mousePressed){
          state = GAME_RUN;
        }
      }else{
      image(startNormal,BOTTOM_LEFT,BOTTOM_UP);
      }
      break;
      
    // Game Run
      case GAME_RUN:
      image(bg,0,0);
      //grass field
      color(RGB);
      fill(124,204,25);
      noStroke();
      rect(0,145,640,15);
      
      //bg
      image(soil,0,160);
      image(groundhogIdle,groundhogIdleX,groundhogIdleY);
      
      //sun
      fill(253, 184, 19);
      stroke(255,255,0);
      strokeWeight(5);
      ellipse(590,50,120,120);
      
      //life 
      image(life,lifeX - LIFE_GAP - LIFE_WIDTH,lifeY);
      image(life,lifeX,lifeY);
      image(life,lifeX + LIFE_GAP + LIFE_WIDTH,lifeY);
      
      //soldier
      image(soldier,soldierX,soldierY);
      soldierX = soldierX + soldierSpeed;
      soldierX %= width;
      
      //cabbage
      image(cabbage,cabbageX,cabbageY);
     
      //control
      if(uppressed){
        image(groundhogIdle,groundhogIdleX,groundhogIdleY);
        groundhogIdleY -= groundhogSpeed;
        if(groundhogIdleY < groundhogWidth ) groundhogIdleY = groundhogWidth;
    }
      if(downpressed){
        image(groundhogDown,groundhogIdleX,groundhogIdleY);
        groundhogIdleY += groundhogSpeed;
        if(groundhogIdleY + groundhogWidth > height ) groundhogIdleY = height - groundhogWidth;
    }
      if(leftpressed){
        image(groundhogLeft,groundhogIdleX,groundhogIdleY);
        groundhogIdleX -= groundhogSpeed;
        if(groundhogIdleX < 0 ) groundhogIdleX = 0;
    }
      if(rightpressed){
        image(groundhogRight,groundhogIdleX,groundhogIdleY);
        groundhogIdleX += groundhogSpeed;
        if(groundhogIdleX > width - groundhogWidth ) groundhogIdleX = width - groundhogWidth;
    }
    
      // catch cabbage
      if(cabbageX + cabbageWidth > groundhogIdleX && groundhogIdleX + groundhogWidth > cabbageX &&
         cabbageY + cabbageWidth > groundhogIdleY && groundhogIdleY + groundhogWidth > cabbageY ){
         lifeX = lifeX + LIFE_GAP + LIFE_WIDTH;
         cabbageX = -width;
         }
    
      //AABB touch
      if( soldierX + soldierWidth > groundhogIdleX && groundhogIdleX + groundhogWidth > soldierX &&
          soldierY + soldierWidth > groundhogIdleY && groundhogIdleY + groundhogWidth > soldierY){ 
        groundhogIdleX = width/2;
        groundhogIdleY = height/6;
        lifeX = lifeX - LIFE_GAP - LIFE_WIDTH;
      }
      
      // no heart
      if(lifeX < -LIFE_GAP - LIFE_WIDTH ){
        state = GAME_OVER;
      }
      break;
      
    // Game Over 
    case GAME_OVER :
    image(gameover,0,0);
    if( mouseX > BOTTOM_LEFT && BOTTOM_RIGHT > mouseX &&
        mouseY > BOTTOM_UP && mouseY < BOTTOM_DOWN){
      image(restartHovered,BOTTOM_LEFT,BOTTOM_UP);
      if( mousePressed ){
    state = GAME_RUN;
    lifeX = lifeX + LIFE_GAP + LIFE_WIDTH;
    lifeX = lifeX + LIFE_GAP + LIFE_WIDTH;
    groundhogIdleX = width/2;
    groundhogIdleY = height/6;
    cabbageX = floor(random(1,8))*80;
    cabbageY = floor(random(2,6))*80;
    soldierX = 0;
    soldierY = floor(random(2,6))*80;
  }
        }
    else{
    image(restartNormal,BOTTOM_LEFT,BOTTOM_UP);
  }       
    break;
    
    }
    }
    
void keyPressed(){
  switch(keyCode){
    case UP:uppressed = true;
    if(uppressed){
    groundhogIdleY -= groundhogWidth;
  }
    break;
    case DOWN:downpressed = true;
    if(downpressed){
    groundhogIdleY += groundhogWidth;
  }
    break;
    case LEFT:leftpressed = true;
    if(leftpressed){
    groundhogIdleX -= groundhogWidth;
  }
    break;
    case RIGHT:rightpressed = true;
    if(rightpressed){
    groundhogIdleX += groundhogWidth;
  }
    break;
  }
}

void keyReleased(){
  switch(keyCode){
    case UP: uppressed = false;
    break;
    case DOWN:downpressed = false;
    break;
    case LEFT:leftpressed = false;
    break;
    case RIGHT:rightpressed = false;
    break;
  }
}
