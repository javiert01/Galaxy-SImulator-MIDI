class Star {
  float majorAxisLen;
  float minorAxisLen;
  float theta;
  float deltaTheta;
  
   Star(float majorAxisLen_) {
    majorAxisLen = majorAxisLen_;
    minorAxisLen = majorAxisLen * 0.7;
    theta = random(2*PI);
    deltaTheta = 0.01;
  }

  void display() {
    float x = (majorAxisLen/2)*cos(theta);
    float y = (minorAxisLen/2)*sin(theta);
    noStroke();
    fill(119, 2, 255%y, 400);
    circle(x,y,4);
  }

  void update() {
    theta += deltaTheta;
  }
}
