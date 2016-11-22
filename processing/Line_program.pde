ArrayList<Particle> particles;
int count = 100;
void setup() {
  size(1000,1000);
  particles = new ArrayList<Particle>();
  frameRate(120);
}
void draw() {
  background(0);
  int k = 0;
  while (k < count) {
      particles.add(new Particle(new PVector(width/2,50)));
      k++;
  }
  int i = 0;
  while (i != count) {
   Particle p = (Particle) particles.get(i);
   i++;
   int j = 0;
   while (j != count){
     Particle p2 = (Particle) particles.get(j);
     float x = p2.location.x - p.location.x;
     float y = p2.location.y - p.location.y;
     if (pow(x, 2) + pow(y, 2) < 20000){
       stroke(100*2);
       line(p2.location.x,p2.location.y,p.location.x,p.location.y);
       strokeWeight(0.2);
     }
     j++;
   }
   p.run();
  }
}

class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  Particle(PVector l) {
    acceleration = new PVector(0,0);
    velocity = new PVector(random(-0.3,0.3),random(-0.3,0.3));
    location = new PVector(random(0,width),random(0,height));
  }
  void run() {
    update();
    borders();
  }
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    stroke(255);
    ellipse(location.x,location.y,2,2);
  }
  void borders() {
    if (location.x > height || location.x < 1) {
      velocity.x *= -1;
    }
    if (location.y > height || location.y < 1) {
      velocity.y *= -1;
    }
  }
}
