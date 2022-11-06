

import themidibus.*;
import javax.sound.midi.MidiMessage; 


MidiBus myBus;
Emitter emitter;
ArrayList<Star> stars;
ArrayList<StarSP> starSPList;
ArrayList<Integer> starsCount;
ArrayList<ShootingStar> shootingStars;
int numberOfShootingStars = 20;
int numberOfStars;
int numberOfStarsSP = 500;
float sizeDiff = 0.15;
float rotationGradient;
PImage img;
boolean isDecreasing = false;
boolean canShow = true;

void setup() {
  size(1400, 800, P2D);
  numberOfStars = 3000;
  rotationGradient = PI/numberOfStars;
  stars = new ArrayList();
  starSPList = new ArrayList();
  starsCount = new ArrayList();
  shootingStars = new ArrayList();
  for(int i=0; i<numberOfStars; i++) {
    float majorAxisLen = 20 + (i*sizeDiff);
    stars.add(new Star(majorAxisLen));
  }
  for(int i=0; i<numberOfStarsSP; i++) {
    starSPList.add(new StarSP());
    starsCount.add(i);
  }
                                                                                                                                                                                                                 
  // Create an alpha masked image to be applied as the particle's texture
  img = loadImage("texture.png");
  emitter = new Emitter(width/2, height/2);
  MidiBus.list(); 
  myBus = new MidiBus(this, 1, 1);
}

void draw() {
  // Additive blending!
  blendMode(ADD);
  background(0);
  float showShootingStarProb = random(0,1);
  if(showShootingStarProb < 0.02) {
    shootingStars.add(new ShootingStar(random(width), 0));
  }
  for(int i = shootingStars.size() -1; i>=0; i--) {
    shootingStars.get(i).update();
    shootingStars.get(i).show();
    if(shootingStars.get(i).isOut()) {
      shootingStars.remove(i);
    }
  }
  
  
  PVector force = new PVector(0, -0.1);
  emitter.applyForce(force);
  float dir = map(mouseX, 0, width, -0.3, 0.3);
  PVector wind = new PVector(dir, 0);
  emitter.applyForce(wind);
  emitter.emit(1);
  emitter.show();
  emitter.update();
  pushMatrix();
  noFill();
  stroke(255);
  translate(width/2, height/2);
  for(int i=0; i<numberOfStars; i++) {
    rotate(rotationGradient);
    stars.get(i).display();
    stars.get(i).update();
  }
  if(rotationGradient < 0.0035 && !isDecreasing) {
    rotationGradient+=0.000001;
  } 
  if(rotationGradient > 0.0035) {
    isDecreasing = true;
  }
  if(isDecreasing) {
    rotationGradient-=0.000001;
  }
  if(rotationGradient <= PI/numberOfStars) {
    isDecreasing = false;
  }
  popMatrix();
  for(int i=0; i<starSPList.size(); i++) {
    starSPList.get(i).update();
    starSPList.get(i).show();
  }
}

void midiMessage(MidiMessage message, long timestamp, String bus_name) { 
  if(message.getLength() < 2) {
    return;
  }
  canShow = !canShow;
  int note = (int)(message.getMessage()[1] & 0xFF);
  int velocity = (int)(message.getMessage()[2] & 0xFF) ;
   if (starsCount.size() > 0 && canShow) {
     int randomStarIndex = (int) random(starsCount.size());
      int randomStarCount = starsCount.get(randomStarIndex);
      StarSP currentStar = starSPList.get(randomStarCount);
      currentStar.x = random(width);
      currentStar.y = 80;
      currentStar.canShow = true;
      starsCount.remove(randomStarIndex);
      return;
    }
  println("Bus " + bus_name + ": Note "+ note);
}

void mouseClicked() {
   if (starsCount.size() > 0 && canShow) {
      int randomStarIndex = (int) random(starsCount.size());
      int randomStarCount = starsCount.get(randomStarIndex);
      StarSP currentStar = starSPList.get(randomStarCount);
      currentStar.x = random(width);
      currentStar.y = 80;
      currentStar.canShow = true;
      starsCount.remove(randomStarIndex);
      return;
    }
}
