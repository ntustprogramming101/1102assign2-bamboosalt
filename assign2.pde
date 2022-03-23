PImage backgroundImg, titleImg;
PImage soilImg;
PImage lifeImg;
PImage hogImg, cabbageImg, hogDownImg, hogLeftImg, hogRightImg;
PImage soldierImg;
PImage gameoverImg, reHoveredImg, reNormalImg, startHoveredImg, startNormalImg;

int x, y, c, a, soildH, BLOCK;
int gameState, heart1X , heartY, heart2X, heart3X;
int lifeState, state, hogState;

final int GAME_START= 0;
final int GAME_RUN= 1;
final int GAME_LOSE= 2;

final int HOG_ORI=0;
final int HOG_RIGHT=1;
final int HOG_LEFT=2;
final int HOG_DOWN=3;

final int HEART0=0;
final int HEART1=1;
final int HEART2=2;
final int HEART3=3;

float time=0;
float hogX, hogY, cabbageX, cabbageY;

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
   hogX=320.0;
   hogY=80.0;
   cabbageX=0.0;
   cabbageY=160.0;
   heart1X=10;
   heart2X=80;
   heart3X=150;
   heartY=10;
  c=floor(random(3));// cabbageUpPlace
  a=floor(random(8));// cabbageRightPlace
   gameState=GAME_START;
   lifeState= HEART2;
   state=0;
   hogState=HOG_ORI;
   BLOCK=80;
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
    //fix float
    if(time==15.0){
    hogState=HOG_ORI;
    if(hogX%BLOCK<30){
      hogX=hogX-hogX%BLOCK;
    }else{
      hogX=hogX-hogX%BLOCK+BLOCK;
    }
    if(hogY%BLOCK<30){
      hogY=hogY-hogY%BLOCK;
    }else{
      hogY=hogY-hogY%BLOCK+BLOCK;
    }
   
     //cabbage fix float
    if(cabbageX%BLOCK<30){
      cabbageX=cabbageX-cabbageX%BLOCK;
    }else{
      cabbageX=cabbageX-cabbageX%BLOCK+BLOCK;
    }
    if(cabbageY%BLOCK<30){
      cabbageY=cabbageY-cabbageY%BLOCK;
    }else{
      cabbageY=cabbageY-cabbageY%BLOCK+BLOCK;
    }
     println(cabbageY);
    println(cabbageX);
     println(hogY);
    println(hogX);
  }
    
    if(hogX>width-80){
    hogX=width-80;
  }
  if(hogX<0){
    hogX=0.0;
  }
  if(hogY>height-80){
    hogY=height-80;
  }
  
  switch(hogState){
    case HOG_ORI:
    image(hogImg,hogX,hogY);
    time=0.0;
    break;
    case HOG_RIGHT:
    image(hogRightImg,hogX,hogY);
    hogX+=(80.0/15.0);
    time++;
    break;
    case HOG_LEFT:
    image(hogLeftImg,hogX,hogY);
    hogX-=(80.0/15.0);
    time++;
    break;
    case HOG_DOWN:
    image(hogDownImg,hogX,hogY);
    hogY+=(80.0/15.0);
    time++;
    break;
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
     hogState=HOG_ORI;
   }
   //ate cabbage
   if(hogY>=cabbageY+80*c){
  if(hogX+80==cabbageX+80*a+80&&hogX+80>cabbageX+80*a){
  
     cabbageX=-(cabbageX+80*a);
     cabbageY=-(cabbageY+80*c);
     image(cabbageImg,cabbageX,cabbageY); 
   lifeState=HEART2;
    }
   }
    image(cabbageImg,cabbageX+80*a,cabbageY+80*c);
   
  
   break;
   case HEART2:
   image(lifeImg,heart1X,heartY);
   image(lifeImg,heart2X,heartY);  
   //hit solider
   if(hogX+80>x&&hogX<x+80&&hogY+80>y+80*soildH&&hogY<y+80*soildH+80){
     hogX=320.0;
     hogY=80.0;
     image(hogImg,hogX,hogY);
     hogState=HOG_ORI;
     lifeState=HEART1;
   }
   //ate cabbage
   
  
   if(hogY>=cabbageY+80*c){
  if(hogX+80==cabbageX+80*a+80&&hogX+80>cabbageX+80*a){
  
     cabbageX=-(cabbageX+80*a);
     cabbageY=-(cabbageY+80*c);
     image(cabbageImg,cabbageX,cabbageY); 
   lifeState=HEART3;
    }
   }
    image(cabbageImg,cabbageX+80*a,cabbageY+80*c);
   
   break;
    case HEART3:
    image(lifeImg,heart1X,heartY);
    image(lifeImg,heart2X,heartY);
    image(lifeImg,heart3X,heartY);
    //hit solider
    if(hogX+80>x&&hogX<x+80&&hogY+80>y+80*soildH&&hogY<y+80*soildH+80){
     hogX=320.0;
     hogY=80.0;
     image(hogImg,hogX,hogY);
     hogState=HOG_ORI;
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
     hogX=320.0;
     hogY=80.0;
     image(hogImg,hogX,hogY);
     
     // init cabbage
     cabbageX=0.0;
     cabbageY=160.0;
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
  if(hogState==HOG_ORI){
  right=true;
  hogState=HOG_RIGHT;
  
  time=0.0;
  }
  break;
   case DOWN: 
 if(hogState==HOG_ORI){
  down=true;
  hogState=HOG_DOWN;
  time=0.0;
  }
   
  break;
   case LEFT: 
if(hogState==HOG_ORI){
   left=true;
  hogState=HOG_LEFT;
  time=0.0;
  break;
  }
  }
}
}

void keyReleased(){
  if(key==CODED){
  switch(keyCode){
  case RIGHT:
  if(hogState==HOG_ORI){
  right=false;
  hogState=HOG_ORI;
  time=0.0;
  }
  break;
   case DOWN:
   if(hogState==HOG_ORI){
   down=false;
  hogState=HOG_ORI;
  time=0.0;
   }
  break;
   case LEFT:
   if(hogState==HOG_ORI){
   left=false;
  hogState=HOG_ORI;
  time=0.0;
   }
  break;
}
  }
}
