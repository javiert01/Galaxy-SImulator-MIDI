class ShootingStar {
 PVector position;
 float z = random(5,10);
 float radius = map(z,5,10,15,25);
 float tailLength = map(z,5,10,100,120);
 float randomVel = map(z,5,10,6,10);
 PVector velocity = new PVector(randomVel, randomVel);
 ShootingStar(float x, float y) {
   position = new PVector(x, y);
 }
 
 void show() {
   noStroke();
   fill(125, 400);
   circle(position.x, position.y, radius);
   strokeWeight(2);
   stroke(158);
   line(position.x - tailLength, position.y - tailLength + 20, position.x, position.y);
 }
 
 boolean isOut() {
    return (position.x > width + tailLength && position.y > height + tailLength);
      
 }
 
 void update() {
   position.add(velocity);
 }
 
}
