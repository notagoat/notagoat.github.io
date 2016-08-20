int tarx;
int tary;
float time;

class Hunter {
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector size;
  float r = 2;
  float topspeed;
  double distance;
  double lastdistance; //This is needed for checking if closer
  int colour;   //Sets random colour

  Hunter() {  //Initiate cell
    float sizeV = random(2,3);
    size = new PVector(3 + sizeV,3 + sizeV);
    location = new PVector(random(0,height), random(0, width));
    velocity = new PVector(0, 0);
    topspeed = size.x + random(-2, 2);
    acceleration = new PVector(size.x / 5, size.y / 5);
    colour = int(random(155,255));  //All the random variables allow many different cells to be made and for selection bias to occur
  }
  void update() {
    lastdistance = distance;
    PVector target = new PVector(tarx, tary);
    fill(255,0,0);
    ellipse(tarx, tary, 10, 10);

    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
    distance = Math.sqrt(Math.pow(tarx-location.x, 2) + Math.pow(tary-location.y, 2));
    acceleration = PVector.sub(target, location);
    acceleration.setMag(0.5 + random(-1, 1));
    if (lastdistance > distance) {
      acceleration.setMag(acceleration.mag()*0.5);  //Slow cell if closer
    }
    if (distance <= 5.0 ) {
      tarx = int(random(width));
      tary = int(random(height));
      size.x += 5;
      size.y += 5;  //Check if eating. If eating then gain size, otherwise shrink
    } else {
      size.x -= 0.005;
      size.y -= 0.005;
    }
  }
  void borders() {
    if (location.x < -1) location.x = width+1;
    if (location.y < -1) location.y = height+1;
    if (location.x > width+1) location.x = -1;
    if (location.y > height+1) location.y = -1;
  }
  void display() {
    strokeWeight(1);
    fill(colour);
    //blendMode(BLEND);
    ellipse(location.x, location.y, size.x, size.y);
  }
  boolean isDead() {
  if (size.x < 1 + random(-0.5,0.5)) {
    return true;    //Simple death check
  } else {
    return false;
  }
 }
}


int dead;
int timer;
int value = 0;
ArrayList<Hunter> hunter;
void setup() {
  //fullScreen(P3D);
  size(1000,1000);
  frameRate(100);
  hunter = new ArrayList<Hunter>(); //init array of hunters
}

void draw() {
  background(0);
  timer += 1;
  if (hunter.size() < 100) { //300 is good, no lag but still interesting. 100 for JS mode. 300 for Java mode.
    hunter.add(new Hunter());
  }
  for (int i = hunter.size()-1; i >=0; i--) {
    Hunter h = (Hunter) hunter.get(i);
    h.update();
    h.borders();
    h.display();
    if (h.isDead()) {
      hunter.remove(i);
      dead += 1;
   }
   fill(250);
   text("Cells Alive: " + hunter.size() ,10,20);
   text("Cells Killed: " + dead,10,40);
   text("Simulation Time: " + timer / 100,10,60); //Can be turned off for a cleaner screen
  }
}
