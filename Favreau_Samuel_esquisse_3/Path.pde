class Path {
  //Global variables
  int time;

  float fpx; //First point X
  float spx; //Second point X
  float spy; //Second point Y

  PVector[] stepsTrack = new PVector[4];

  boolean isFinished = false;

  int opacity = 255;

  FireWork fireWork;
  
  float reflectY;

  color mainColor = color(random(360), 80, 100);

  //Constructor
  Path(float x, float y) {
    //Creates new PVectors to keep track of the position of the curve
    for (int i = 0; i < stepsTrack.length; i++) {
      stepsTrack[i] = new PVector();
    }
    
    //Sets the starting and ending points of the path
    time = 0;
    fpx = random(width);
    spx = x;
    spy = y + 50;
    
    //Creates a new firework and sets it's color
    fireWork = new FireWork();
    fireWork.setColor(mainColor);
    
    //Choses a random position for the reflection
    reflectY = random(sky.height + 150, height);
  }

  void display() {
    //Determins the positions of the curve according to the bezier information and the timing
    for (int i = 0; i < stepsTrack.length; i++) {
      float t = constrain(time - i*5, 0, 100) / float(100);
      float x = bezierPoint(fpx, fpx, spx, spx, t);
      float y = bezierPoint(height, height - 400, spy - 400, spy, t);

      stepsTrack[i].x = x;
      stepsTrack[i].y = y;
    }

    //Puts all of the points on the same spot when the animation is over
    if (time >= 100) {
      for (int i = 0; i < stepsTrack.length; i++) {
        stepsTrack[i].x = stepsTrack[1].x;
        stepsTrack[i].y = stepsTrack[1].y;
      }
      isFinished = true;
    }

    noFill();
    
    //Draws the glow effect on the curve
    for (int i = 0; i < 10; i++) {
      strokeWeight(map(time, 0, 100, 10, 0) + i);
      stroke(mainColor, map(opacity, 0, 255, 0, 10));
      drawCurve();
    }
    
    //Draws the white line on the curve
    strokeWeight(map(time, 0, 100, 10, 0));
    stroke(255, opacity);
    drawCurve();

    //Removes the path and show the firework when the animation is over
    if (isFinished) {
      fireWork.setPosition(stepsTrack[1].x, stepsTrack[1].y);
      fireWork.display();
      fireWork.update();
      opacity = 0;
      reflexion();
    }
  }

  //Updates the animation
  void update() {
    if (time < 100) {
      time +=2;
    }
  }

  //Draws the curve following the bezier
  void drawCurve() {
    curve(stepsTrack[0].x, stepsTrack[0].y, 
      stepsTrack[1].x, stepsTrack[1].y, 
      stepsTrack[2].x, stepsTrack[2].y, 
      stepsTrack[3].x, stepsTrack[3].y);
  }

  //Draws the reflexion in the water
  void reflexion() {
    push();
    translate(stepsTrack[1].x, reflectY);
    scale(1, -1);
    fireWork.setPosition(0, 0);
    fireWork.display();
    fireWork.update();
    pop();
  }
}
