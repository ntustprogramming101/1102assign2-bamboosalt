PImage backgroundImg, titleImg;
PImage soilImg;
PImage lifeImg;
PImage hogImg, cabbageImg, hogDownImg, hogLeftImg, hogRightImg;
PImage soldierImg;
PImage gameoverImg, reHoveredImg, reNormalImg, startHoveredImg, startNormalImg;

int x, y, c, a, soildH, hogX, hogY, cabbageX, cabbageY;
int gameState, heart1X , heartY, heart2X, heart3X;
int lifeState, state;

final int GAME_START= 0;
final int GAME_RUN= 1;
final int GAME_LOSE= 2;

final int HEART0=0;
final int HEART1=1;
final int HEART2=2;
final int HEART3=3;

boolean right= false;
boolean down= false;
boolean left= false;
boolean cabbage=false;

void setup() {
	size(640, 480, P2D);

   backgroundImg=loadImage("img/bg.jpg");
   gameoverImg=loadImage("img/gameover.jpg");
   titleImg=loadImage("img/title.jpg");
   soilImg=loadImage("img/soil.png");
   lifeImg=loadImage("img/life.png");
   hogImg=loadImage("img/groundhogIdle.png");
   hogDownImg=loadImage("img/groundhogDown.png");
   hogLeftImg=loadImage("img/groundhogLeft.png");
   hogRightImg=loadImage("img/groundhogRight.png");
   cabbageImg=loadImage("img/cabbage.png");
   soldierImg=loadImage("img/soldier.png");
   reHoveredImg=loadImage("img/restartHovered.png");
   reNormalImg=loadImage("img/restartNormal.png");
   startHoveredImg=loadImage("img/startHovered.png");
   startNormalImg=loadImage("img/startNormal.png");


   x=0;
   y=160;
   soildH=floor(random(1,3));
   hogX=320;
   hogY=80;
   cabbageX=0;
   cabbageY=160;
   heart1X=10;
   heart2X=80;
   heart3X=150;
   heartY=10;
  c=floor(random(3));// cabbageUpPlace
  a=floor(random(8));// cabbageRightPlace
   gameState=GAME_START;
   lifeState= 2;
   state=0;
}

void draw() {
  
switch(gameState){
		case GAME_START: 
image(titleImg,0,0);
image(startNormalImg,248,360);
  
  
if(mouseX>248&&mouseX<392&&mouseY>360&&mouseY<420){
  image(startHoveredImg,248,360);
  if(mousePressed){
 gameState=GAME_RUN;
  }
}
  

break;
		case GAME_RUN: 
 image(backgroundImg,0,0);
  
  image(soilImg,0,160);

  //green
  noStroke();
  fill(124,204,25);
   rect(0,145,640,15);
  
  //sun
  fill(255,255,0);
   ellipse(590,50,130,130);
  
  fill(253,184,19);
   ellipse(590,50,120,120);
   
   
   
    //hog
      int time=0;
 if(time<=15){
    if(hogX>width-80){
    hogX=width-80;
  }
  if(hogX<0){
    hogX=0;
  }
if(keyPressed){
  image(hogImg,-80,-80);
  if(right){
    image(hogRightImg,hogX,hogY);
  }
   if(left){
     image(hogLeftImg,hogX,hogY); 
   }
   if(down){
   image(hogDownImg,hogX,hogY);
   }
}else{
     image(hogImg,hogX,hogY);
   }
     
}  
   //soldier
  image(soldierImg,x,y+80*soildH);
  x+=4;
  if(x>=640){x=-80;}
  x%=640;
   
   //life
  switch(lifeState){
   case HEART0:
   
   gameState=GAME_LOSE;
   break;
   case HEART1:
     image(lifeImg,heart1X,heartY);
     //hit solider
   if(hogX+80>x&&hogX<x+80&&hogY+80>y+80*soildH&&hogY<y+80*soildH+80){
     lifeState=HEART0;
   }
   //ate cabbage
  if(hogX==cabbageX+80*a&&hogY==cabbageY+80*c){
     cabbageX=-(cabbageX+80*a);
     cabbageY=-(cabbageY+80*c);
     image(cabbageImg,cabbageX,cabbageY); 
   lifeState=HEART2;
    }
   image(cabbageImg,cabbageX+80*a,cabbageY+80*c);
   
  
   break;
   case HEART2:
   image(lifeImg,heart1X,heartY);
   image(lifeImg,heart2X,heartY);  
   //hit solider
   if(hogX+80>x&&hogX<x+80&&hogY+80>y+80*soildH&&hogY<y+80*soildH+80){
     hogX=320;
     hogY=80;
     image(hogImg,hogX,hogY);
     lifeState=HEART1;
   }
   //ate cabbage
   image(cabbageImg,cabbageX+80*a,cabbageY+80*c);
   if(hogX==cabbageX+80*a&&hogY==cabbageY+80*c){
     cabbageX=-(cabbageX+80*a);
     cabbageY=-(cabbageY+80*c);
     image(cabbageImg,cabbageX,cabbageY); 
   lifeState=HEART3;
    }
   
   
   break;
    case HEART3:
    image(lifeImg,heart1X,heartY);
    image(lifeImg,heart2X,heartY);
    image(lifeImg,heart3X,heartY);
    //hit solider
    if(hogX+80>x&&hogX<x+80&&hogY+80>y+80*soildH&&hogY<y+80*soildH+80){
     hogX=320;
     hogY=80;
     image(hogImg,hogX,hogY);
     lifeState=HEART2;
   }
  
   break;
  
  }
  
break;

		case GAME_LOSE: 
image(gameoverImg,0,0);
image(reNormalImg,248,360);
  
if(mouseX>248&&mouseX<392&&mouseY>360&&mouseY<420){
  image(reHoveredImg,248,360);
    if(mousePressed){
     lifeState=HEART2;
     
     // init hog
     hogX=320;
     hogY=80;
     image(hogImg,hogX,hogY);
     
     // init cabbage
     cabbageX=0;
     cabbageY=160;
     c=floor(random(3));// cabbageUpPlace
     a=floor(random(8));// cabbageRightPlace
     image(cabbageImg,cabbageX+80*a,cabbageY+80*c);
     
     gameState=GAME_RUN;

  }
}


break;

}
}
void keyPressed(){
  if(key==CODED){
  switch(keyCode){
  case RIGHT:  
   
  hogX+=80;
  right=true;
  break;
   case DOWN: 
 
  hogY+=80;
   down=true;
  break;
   case LEFT: 

   hogX-=80;
   left=true;
  break;
  }
  }
}


void keyReleased(){
  if(key==CODED){
  switch(keyCode){
  case RIGHT:
  right=false;
  break;
   case DOWN:
   down=false;
  break;
   case LEFT:
   left=false;
  break;
}
  }
}
