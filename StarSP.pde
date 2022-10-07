class StarSP {
  float x = random(width);
  float y = random(-500,-50);
  float z = random(0,10);
  float radius = map(z,0,10,10,16);
  float yspeed = map(z,0,10,0.5,2);
  IntList palette = new IntList();
  color starColor;
  int initialAnimationDuration = 500;
  boolean canShow = false;
  
  StarSP() {
    palette.append(color(25,35,255));
    palette.append(color(101,54,255));
    starColor = palette.get(int (random(palette.size())));
  }
  
   void update() {
     if (this.canShow) {
      this.initialAnimationDuration -= 5;
     }
     y = y + yspeed;
     if(y > height) {
       y = random(-200, -100);
     }
   }
   
   boolean initialAnimationFinished() {
     return this.initialAnimationDuration < 0;
   }
   
   void show() {
     if(!this.canShow){
       return;
     }
     float thick = map(z, 0,20,1,3);
     
     imageMode(CENTER);
     tint(starColor);
     if (!this.initialAnimationFinished()) {
       pushMatrix();
       blendMode(BLEND);
      float size = map(this.initialAnimationDuration, 0, 300, this.radius, this.radius + 20);
      float lineLength = map(this.initialAnimationDuration, 0, 300, 0, 80);
      fill(starColor, 100);
      rect(x,y - lineLength, 10, lineLength);
      rect(x, y -lineLength, 30, 5);
      strokeWeight(thick);
      image(img,x,y, size, size);
      popMatrix();
      return;
    }
      
    strokeWeight(thick);
    image(img,x,y, radius, radius);
     
     
     //circle(x, y, radius);
   }
}
