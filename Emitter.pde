class Emitter {
  PVector position;
  ArrayList<Particle> particles;
  
  Emitter(int x, int y) {
    particles = new ArrayList();              // Initialize the arraylist
    position = new PVector(x, y);                        // Store the origin point
  }
  
  void emit(int num) {
     for (int i = 0; i < num; i++) {
      particles.add(new Particle(this.position.x, this.position.y));    // Add "num" amount of particles to the arraylist
    }
  }
  
  void applyForce(PVector force) {
     for (int i = 0; i < this.particles.size(); i++) {
       particles.get(i).applyForce(force);    // Add "num" amount of particles to the arraylist
    }
  }
  
  void update() {
     for (int i = 0; i < this.particles.size(); i++) {
       particles.get(i).update();    // Add "num" amount of particles to the arraylist
    }
    for (int i = this.particles.size() - 1; i >= 0 ; i--) {
       if(this.particles.get(i).isFinished()){
         particles.remove(i);
       }// Add "num" amount of particles to the arraylist
    }
  }
  
  void show() {
    for (int i = 0; i < this.particles.size(); i++) {
       particles.get(i).show();    // Add "num" amount of particles to the arraylist
    }
  }
}
