class FireWork {
  //Global variables
  int time;

  int fireNb = int(random(5, 30));

  float[] fpx = new float[fireNb]; //First point X
  float[] fpy = new float[fireNb]; //First point Y
  float[] spx = new float[fireNb]; //Second point X
  float[] spy = new float[fireNb]; //Second point Y

  PVector[][] stepsFire = new PVector[fireNb][4];

  boolean isFinished = false;

  int opacity = 0;

  float posX;
  float posY;

  color mainColor;
  
  float radius = random(10, 100);
  float handleOffset = random(10, 100);

  //Constructor
  FireWork() {
    //Creates new PVectors to keep track of the position of the curves
    for (int i = 0; i < fireNb; i++) {
      for (int j = 0; j < 4; j++) {
        stepsFire[i][j] = new PVector();
      }
    }

    time = 0;
  }

  void display() {
    //Determins the positions of the curve according to the bezier information and the timing
    for (int i = 0; i < fireNb; i++) {
      for (int j = 0; j < 4; j++) {
        float t = constrain(time - j*20, 0, 100) / float(100);
        float x = bezierPoint(fpx[i], fpx[i], spx[i], spx[i], t);
        float y = bezierPoint(fpy[i], fpy[i] - handleOffset, spy[i] - handleOffset, spy[i], t);

        stepsFire[i][j].x = x;
        stepsFire[i][j].y = y;
      }
    }
    
    //Manages the opacity of the curves
    if (time < 100) {
      opacity = constrain(int(map(time, 0, 99, 0, 255)), 0, 255);
    } else {
      opacity = constrain(int(map(time, 100, 150, 255, 0)), 0, 255);
      if (opacity == 0) {
        isFinished = true;
      }
    }

    //Draws the glow effect on the curve
    noFill();
    for (int j = 0; j < 10; j++) {
      stroke(mainColor, map(opacity, 0, 255, 0, 10));
      strokeWeight(3 + j);
      for (int i = 0; i < fireNb; i++) {
        drawCurve(i);
      }
    }
    
    //Draws the white line on the curve
    stroke(255, opacity);
    strokeWeight(3);
    for (int i = 0; i < fireNb; i++) {
      drawCurve(i);
    }
  }

  //Updates the animation
  void update() {
    time +=2;
  }
  
  //Sets the starting and ending points of the firework
  void setPosition(float x, float y) {
    posX = x;
    posY = y;

    for (int i = 0; i < fireNb; i ++) {
      fpx[i] = posX; 
      fpy[i] = posY;
      spx[i] = posX + sin(radians(i * 360/fireNb))*radius;
      spy[i] = posY + cos(radians(i * 360/fireNb))*radius;
    }
  }
  
  //Sets the color
  void setColor(color c) {
    mainColor = c;
  }

  //Draws the curve following the bezier
  void drawCurve(int i) {
    curve(stepsFire[i][0].x, stepsFire[i][0].y, 
      stepsFire[i][1].x, stepsFire[i][1].y, 
      stepsFire[i][2].x, stepsFire[i][2].y, 
      stepsFire[i][3].x, stepsFire[i][3].y);
  }
}
