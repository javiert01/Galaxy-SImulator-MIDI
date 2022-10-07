// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Simple Particle System

class Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  float lifespan;
  float r;

  Particle(float x, float y) {
    acc = new PVector(0,0);
    vel = new PVector(random(-1,1),random(-1,1));
    vel.mult(random(0.5,2));
    pos = new PVector(x,y);
    r = 64;
    lifespan = 255;
  }

  void applyForce(PVector force) {
    this.acc.add(force);
  }

  // Method to update position
  void update() {
    vel.add(acc);
    pos.add(vel);
    acc.set(0,0);
    lifespan -= 7.0;
  }

  // Method to display
  void show() {
    imageMode(CENTER);
    tint(140,40,80,lifespan);
    image(img,pos.x,pos.y, r, r);
  }
  
  boolean isFinished() {
    return lifespan <= 0.0;
  }

}
