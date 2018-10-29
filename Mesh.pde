//constraints
int pointDensity = 8;
float maxSpeed = 0;
int lineWeight = 10;

//mods
boolean mouseModSpeedEnabled = false;
float   mouseModSpeedAmplifier = 9;

boolean mouseModColourEnabled = true;
String  mouseModColourAction = "rg"; //rg(Red,Green),rb(Red,Blue),gb(Green,Blue)
boolean mouseModLineBloom = false;
int     mouseModLineBloomAmp = 20; //set to lineWeight if you want to disable
float   mouseModLineBloomRev = 1.0000001; //the lower the number, the slower the bloom reduction

boolean cycleColours = true; //relys on 'mouseModColourAction' settings

//functions
boolean screenshotsEnabled = false; //press any key to take a screenshot

//graphics
String pointEdgeAction = "bounce"; // bounce, teleport, random
int[][] lineColourRange = {{255,100,100},{100,100,200}}; //{{minR,minG,minB},{maxR,maxG,maxB}}, line colours reduce in range when points are closer together.

//sys vars
float[][] points_location = new float[pointDensity][2]; //[pointID][locX,locY]
float[][] points_speed = new float[pointDensity][2]; //[pointID][speedX,speedY]
int frameID = int(random(1,5000));
int originX, originY;
int screenDiag;

void setup(){
  fullScreen();
  frameRate(60);
  originX = int(width/2);
  originY = int(height/2);
  screenDiag = int(pointDistance(0,0,originX,originY));
  for(int point = 0; point < pointDensity; point++){
    points_location[point][0] = random(0,width);
    points_location[point][1] = random(0,height);
    points_speed[point][0] = random(-maxSpeed,maxSpeed);
    points_speed[point][1] = random(-maxSpeed,maxSpeed);
  }
}

void draw(){
  background(22,22,25);
  strokeWeight(lineWeight);
  if(lineWeight < 1.1){
    lineWeight = 1;
  } else{
    if(mouseModLineBloom){
      lineWeight = int(lineWeight/mouseModLineBloomRev);
    }
  }
  
  
  for(int point = 0; point < pointDensity; point++){
    for(int pointChild = 0; pointChild < pointDensity; pointChild++){
      if(pointChild == point){
        pointChild++; 
      } else {
        int pointToChildDistance = int(pointDistance(points_location[point][0],points_location[point][1],points_location[pointChild][0],points_location[pointChild][1]));
        //float distToCenter = (pointDistance(points_location[pointChild][0],points_location[pointChild][1],originX,originY)/screenDiag);
        boolean mouseSwitch = false;
        if(cycleColours){
          if(mouseModColourAction == "rg"){
          }
          else if(mouseModColourAction == "rb"){
          }
          else if(mouseModColourAction == "gb"){
          }
        }
        
        if(mouseModColourEnabled == true && mousePressed){
          if(mouseModColourAction == "rg"){
            if(mouseSwitch == true){
              lineColourRange[0][0] = int(mouseX);
              lineColourRange[0][1] = int(mouseY);
              mouseSwitch = false;
            } else {
              lineColourRange[1][0] = int(mouseX);
              lineColourRange[1][1] = int(mouseY);
              mouseSwitch = true;
            }
          }
          else if(mouseModColourAction == "rb"){
            if(mouseSwitch == true){
              lineColourRange[0][0] = int(mouseX);
              lineColourRange[0][2] = int(mouseY);
              mouseSwitch = false;
            } else {
              lineColourRange[1][0] = int(mouseX);
              lineColourRange[1][2] = int(mouseY);
              mouseSwitch = true;
            }
          }
          else if(mouseModColourAction == "gb"){
            if(mouseSwitch == true){
              lineColourRange[0][1] = int(mouseX);
              lineColourRange[0][2] = int(mouseY);
              mouseSwitch = false;
            } else {
              lineColourRange[1][1] = int(mouseX);
              lineColourRange[1][2] = int(mouseY);
              mouseSwitch = true;
            }
          }
        }
        
        int lineColourR = int(map(pointToChildDistance,0,int(pointDistance(0,0,width,height)),lineColourRange[0][0],lineColourRange[1][0]));
        int lineColourG = int(map(pointToChildDistance,0,int(pointDistance(0,0,width,height)),lineColourRange[0][1],lineColourRange[1][1]));
        int lineColourB = int(map(pointToChildDistance,0,int(pointDistance(0,0,width,height)),lineColourRange[0][2],lineColourRange[1][2]));
        int lineColourA = int(map(pointToChildDistance,0,int(pointDistance(0,0,width,height)),255,0));
        
        stroke(lineColourR,lineColourG,lineColourB,lineColourA);
        line(points_location[point][0],points_location[point][1],points_location[pointChild][0],points_location[pointChild][1]);
      }
    }
  }
  movePoints();
}

float pointDistance(float p1x, float p1y, float p2x, float p2y){
  return sqrt((sq(abs(p1x)-abs(p2x)))+(sq(abs(p1y)-abs(p2y))));
}

void movePoints(){
  for(int point = 0; point < pointDensity; point++){
    if(mousePressed == true && mouseModSpeedEnabled){
      points_location[point][0] += (points_speed[point][0])*map(mouseX,0,width,-mouseModSpeedAmplifier,mouseModSpeedAmplifier);
      points_location[point][1] += (points_speed[point][1])*map(mouseY,0,height,-mouseModSpeedAmplifier,mouseModSpeedAmplifier); 
    } else {
      points_location[point][0] += (points_speed[point][0]);
      points_location[point][1] += (points_speed[point][1]);
    }
    
    if(pointEdgeAction == "teleport"){
      if(points_location[point][0] > width){
        points_location[point][0] = 0;
      }
      if(points_location[point][1] > height){
        points_location[point][1] = 0;
      }
      if(points_location[point][0] < 0){
        points_location[point][0] = width;
      }
      if(points_location[point][1] < 0){
        points_location[point][1] = height;
      }
    }
    else if(pointEdgeAction == "bounce"){
      if(points_location[point][0] > width || points_location[point][0] < 0){
        points_speed[point][0] *= -1;
      }
      if(points_location[point][1] > height || points_location[point][1] < 0){
        points_speed[point][1] *= -1;
      }
    }
    else if(pointEdgeAction == "random"){
      if(points_location[point][0] > width || points_location[point][0] < 0 || points_location[point][1] > height || points_location[point][1] < 0){
        points_location[point][0] = random(0,width);
        points_location[point][1] = random(0,height);
      }
    }
  }
}

void mousePressed(){
  if(mouseModLineBloom){
  lineWeight = mouseModLineBloomAmp;
  }
}

void keyPressed(){
  if(screenshotsEnabled){
  saveFrame(frameID + ".png");
  frameID = int(random(1,5000));
  }
}
