Vehicle wanderer;
Vehicle[] objarray;

class Vehicle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float wandertheta;
  float maxforce;    
  float maxspeed;    
  int a,b,c;
  
  boolean aup,bup,cup;
  Vehicle(float x, float y) {
    c = int(random(20,220));
    b = int(random(20,220));
    a = int(random(20,220));
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    location = new PVector(x,y);
    r = 6;
    wandertheta = 0;
    maxspeed = 3;
    maxforce = 0.05;
  }

  void run() {
    update();
    borders();
    display();
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
  }

  void wander() {
    float wanderR = 25;        
    float wanderD = 80;       
    float change = 0.3;
    wandertheta += random(-change,change);
    PVector circleloc = velocity.get();
    circleloc.normalize();
    circleloc.mult(wanderD);
    circleloc.add(location);              
    
    float h = velocity.heading2D();  

    PVector circleOffSet = new PVector(wanderR*cos(wandertheta+h),wanderR*sin(wandertheta+h));
    PVector target = PVector.add(circleloc,circleOffSet);
    seek(target);

  }  

  void applyForce(PVector force) {
    acceleration.add(force);
  }
  
  // STEER = DESIRED MINUS VELOCITY
  void seek(PVector target) {
    PVector desired = PVector.sub(target,location); 
    desired.normalize();
    desired.mult(maxspeed);
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }

  void display() {
    float theta = velocity.heading2D() + radians(90);
    if (cup == true){
      c += random(1,3);
      if (c > 220){
        cup = false;
      }
      if (bup == true){
        b += random(1,3);
        if (b > 220){
          bup = false;
        }
        if(aup == true){
          a += random(1,3);
          if (a > 220){
            aup = false;
          }
        } 
      } 
    }
    if (aup == false){
      a -= random(1,3);
      if (a < 20){
        aup = true;
       }
     }
      
     if (cup == false){
       c -= random(1,3);
       if (c < 20){
         cup = true;
       }
     }
      
     if (bup == false){
       b -= random(1,3);
       if (b < 20) {
         bup = true;
       }
     }
    fill(a,b,c);
    pushMatrix();
    translate(location.x,location.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }
  void borders() {
    if (location.x < -r) location.x = width+r;
    if (location.y < -r) location.y = height+r;
    if (location.x > width+r) location.x = -r;
    if (location.y > height+r) location.y = -r;
  }
}

void setup() {
  size(1000,1000);
  noStroke();
  background(0);
  objarray = new Vehicle[1000];
  for (int i = 0; i < objarray.length; i++) {
    objarray[i] = new Vehicle(random(0,width),random(0,height));
  }
}

void draw() {
  for (int i = 0; i < objarray.length; i++) {
    objarray[i].wander();
    objarray[i].run();
  }
}


