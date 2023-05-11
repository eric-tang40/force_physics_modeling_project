int NUM_ORBS = 7;
int DAMPENING = 1;
int MIN_SIZE = 5;
int MAX_SIZE = 50;
int MIN_MASS = 5;
int MAX_MASS = 50;
float GRAVITY = 0.4;
float SPRING_CONST = 0.005;
int SPRING_LENGTH = 100;

boolean moving = false;
boolean bounce = false;
boolean earthGravity = false;
boolean springForce = false;
boolean jetForce = false;
boolean magnetForce = false;
boolean trails = false;

float angle = 0;
int radius = 25;

OrbList orbs;
Orb earth;
Orb sun;

void setup() {
  size(800,600);
  background(255);
  reset(); 
  
  earth = new Orb(width/2 - radius/2, height/10, 35, 1000, #367AEA);
  sun = new FixedOrb(width/2, height/2, 100, 1500, #FFEB36);
}

void draw() {
  background(255);
  displayMode();
  
  orbs.display();
  
  if(moving) {
    if(earthGravity) {
      earth.display(); 
      sun.display();
      orbs.applyGravityOrbs(GRAVITY); //orbs apply gravity to each other
      orbs.applyGravityPlanet(earth, GRAVITY); 
      orbs.applyGravityPlanet(sun, GRAVITY);
      
      earth.moveInCircle(radius);
      earth.run(false, DAMPENING);
    }
    
    if(springForce) {
      orbs.applySprings(SPRING_LENGTH, SPRING_CONST);
    }
    
    orbs.run(false, DAMPENING);
  }
}

void reset() {
  moving = false;
  bounce = false;
  earthGravity = false;
  jetForce = false;
  magnetForce = false;
  
  orbs = new OrbList();
  for (int i=0; i<NUM_ORBS; i++) {
    OrbNode o = new OrbNode( int(random(15, width-15)), int(random(20, height-20)), 25, 5);
    orbs.addFront(o);
  }//make orbs
}//reset

void keyPressed() {
  if(key == ' ') {
    moving = !moving;
  }
  if(key == 'b') {
    bounce = !bounce;
  }
  if(key == 'e') {
    earthGravity = !earthGravity;
  }
  if(key == 's') {
    springForce = !springForce;
  }
  if(key == 'j') {
    jetForce = !jetForce;
  }
  if(key == 'm') {
    magnetForce = !magnetForce;
  }
  if(key == 't') {
    trails = !trails;
  }
  if(key == 'r') {
    reset();
  }
  
  if(key == '1') {
    setupEarthGravity();
  }
  if(key == '2') {
    setupSprings();
  }
}

void setupSprings() {
  moving = false;
  bounce = false;
  earthGravity = false;
  springForce = true;
  jetForce = false;
  magnetForce = false;
  
  orbs = new OrbList();
  
  OrbNode o1 = new FixedOrb(width-15, height/2, 25, 25, color(0));
  orbs.addFront(o1);
  
  for(int i=0; i<NUM_ORBS; i++) {
    OrbNode o = new OrbNode( int(random(15, width-15)), int(random(15, height-15)), 25, 5);
    orbs.addFront(o);
  }
  
  OrbNode o2 = new FixedOrb(15, height/2, 25, 25, color(0));
  orbs.addFront(o2);
  
  o2.c = #E8D4C9;
  
}

void setupEarthGravity() {
  moving = false;
  bounce = false;
  earthGravity = true;
  springForce = false;
  jetForce = false;
  magnetForce = false;
  angle = 0;
  
  orbs = new OrbList(); 
   
  earth = new Orb(width/2 - radius/2, height/10, 35, 1000, #367AEA);
  sun = new FixedOrb(width/2, height/2, 100, 1500, #FFEB36);
  
  int NUM_ORBS = 8;
  int y = 35;
  for(int i=0; i<NUM_ORBS; i++) {
    int mass = int(random(MIN_MASS, MAX_MASS));
    OrbNode o = new OrbNode( width/2, y, 25, mass);
    orbs.addFront(o);
    y += 70;
    
   if (i == NUM_ORBS/2-1) {
      y = height/2 + 70;
    }
  }
}

void displayMode() {
  //initial setup
  color c;
  textAlign(LEFT, TOP);
  textSize(15);
  noStroke();

  //red or green boxes
  c = moving ? color(0, 255, 0) : color(255, 0, 0);
  fill(c);
  rect(0, 0, 53, 20);
  c = bounce ? color(0, 255, 0) : color(255, 0, 0);
  fill(c);
  rect(54, 0, 57, 20);
  c = earthGravity ? color(0, 255, 0) : color(255, 0, 0);
  fill(c);
  rect(112, 0, 105, 20);
  c = springForce ? color(0, 255, 0) : color(255, 0, 0);
  fill(c);
  rect(218, 0, 100, 20);
  c = jetForce ? color(0, 255, 0) : color(255, 0, 0);
  fill(c);
  rect(319, 0, 73, 20);
  c = magnetForce ? color(0, 255, 0) : color(255, 0, 0);
  fill(c);
  rect(393, 0, 59, 20);
  stroke(0);
  fill(0);
  text("MOVING", 1, 0);
  text("BOUNCE", 55, 0);
  text("EARTH GRAVITY", 113, 0);
  text("SPRING FORCE", 218, 0);
  text("JET FORCE", 319, 0);
  text("MAGNET", 393, 0);

}
