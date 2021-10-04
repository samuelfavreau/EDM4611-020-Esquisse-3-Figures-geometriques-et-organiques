/*
 * Class: EDM4611-020
 * Title: Esquisse 3 - Figures géométriques et organiques
 * Autor: Samuel Favreau
 
 * Instructions: Press the Enter keys to save the frame.
 */

//Librairies
import processing.pdf.*;

//Global variables
ArrayList<Path> Path = new ArrayList<Path>();

PImage sky;
PGraphics mnt1;
PGraphics mnt2;
PGraphics mnt3;

FloatList mnt1Points = new FloatList();
FloatList mnt2Points = new FloatList();
FloatList mnt3Points = new FloatList();

color waterColor = color(60, 72, 98);

int timer;
int delay;

boolean canRecord = false;
boolean recording = false;

//----------------------------------------------------------------------------------
//                                    SETUP
//----------------------------------------------------------------------------------

void setup() {
  size(800, 800);

  //Creates the graphics for the sky and the mountains
  sky = createImage(width, int(height*0.75), ARGB);
  mnt1 = createGraphics(width, height);
  mnt2 = createGraphics(width, height);
  mnt3 = createGraphics(width, height);
  
  //Generates the points of the mountains
  for (float i = 0; i <= 100; i += 0.01) {
    mnt1Points.push(noise(i, 0));
    mnt2Points.push(noise(i, 10));
    mnt3Points.push(noise(i, 20));
  }
  
  //Generates the sky and the mountains
  drawSky();
  drawMountain(mnt1, mnt1Points, 200, color(20, 20, 20));
  drawMountain(mnt2, mnt2Points, 150, color(10, 10, 10));
  drawMountain(mnt3, mnt3Points, 100, color(0, 0, 0));
  
  //Sets the color mode to HSB
  colorMode(HSB, 360, 100, 100);
  
  //Sets a new delay
  setDelay();
}

//----------------------------------------------------------------------------------
//                                    DRAW
//----------------------------------------------------------------------------------

void draw() {
  
  //Checks if the program can record the frame
  if(canRecord){
    recording = true;
    beginRecord(PDF, "export/frame-####.pdf");
  }
  
  //Displays the background
  background(waterColor);
  image(sky, 0, 0);
  image(mnt1, 0, 0);
  image(mnt2, 0, 10);
  image(mnt3, 0, 20);

  //Adds new fireworks
  timer++;
  if (millis() - timer >= delay) {
    Path.add(new Path(random(width), random(sky.height - 200)));
    timer = millis();
    setDelay();
  }

  //Displays the fireworks and removes them
  for (int i = 0; i < Path.size(); i++) {
    Path.get(i).display();
    Path.get(i).update();

    if (Path.get(i).fireWork.isFinished) {
      Path.remove(i);
    }
  }
  
  //End the recording if it was in function
  if(canRecord){
    endRecord();
    canRecord = false;
    recording = false;
  }
}

//----------------------------------------------------------------------------------
//                                    FUNCTIONS
//----------------------------------------------------------------------------------

//Draws the sky
void drawSky() {
  push();
  sky.loadPixels();
  for (int y = 0; y < sky.height; y++) {
    for (int x = 0; x < sky.width; x++) {
      colorMode(RGB);
      if (y < sky.height*0.25) {
        sky.pixels[x + y*sky.width] = lerpColor(color(#2C2746), color(#322764), map(y, 0, sky.height*0.25, 0.0, 1.0));
      } else if (y >= sky.height*0.25 && y < sky.height*0.5) {
        sky.pixels[x + y*sky.width] = color(#322764);
      } else {
        sky.pixels[x + y*sky.width] = lerpColor(color(#322764), color(#E8601C), map(y, sky.height*0.5, sky.height, 0.0, 1.0));
      }
    }
  }
  sky.updatePixels();
  pop();
}

//Draws a mountain range
void drawMountain(PGraphics mnt, FloatList mntPoints, int size, color c) {
  mnt.beginDraw();
  mnt.noStroke();
  mnt.fill(c);
  mnt.beginShape();
  mnt.vertex(-5, sky.height);
  for (int i = 0; i <= width + 10; i+= 8) {
    mnt.curveVertex(i - 5, sky.height - mntPoints.get(i)*size);
  }
  mnt.vertex(width + 5, sky.height);
  mnt.endShape(CLOSE);

  mnt.fill(lerpColor(c, waterColor, 0.7));
  mnt.beginShape();
  mnt.vertex(-5, sky.height);
  for (int i = 0; i <= width + 10; i+= 8) {
    mnt.curveVertex(i - 5, sky.height + mntPoints.get(i)*(size - 50));
  }
  mnt.vertex(width + 5, sky.height);
  mnt.endShape(CLOSE);
  mnt.endDraw();
}

//Sets a new delay
void setDelay(){
  delay = int(random(1000));
}

//Checks for mouse presses
void mousePressed() {
  canRecord = true;
}
