int NUM_ORBS = 7;
int DAMPENING = 1;
int MIN_SIZE = 5;
int MAX_SIZE = 50;
int MIN_MASS = 5;
int MAX_MASS = 50;
float GRAVITY = 0.4;
float SPRING_CONST = 0.005;
float MAGNET_CONST = 10;
int SPRING_LENGTH = 100;
float AIR_PRESSURE = 0.1;

boolean moving = false;
boolean bounce = false;
boolean earthGravity = false;
boolean springForce = false;
boolean jetForce = false;
boolean magnetForce = false;
boolean trails = false;
boolean combo = false;

OrbList orbs;
OrbNode mercury, earth, mars, saturn;
Orb sun;
FixedOrb magnet1, magnet2;
Orb magnet3, magnet4;
PImage magnetic, magnetic2;

void setup() {
  size(800,600);
  background(255);
  reset(); 
  
  magnetic = loadImage("magnet.jpg");
  magnetic.resize(55,55);
  
  magnetic2 = loadImage("magnet2.jpg");
  magnetic2.resize(55,55);
}

void draw() {
  background(255);
  displayMode();
  
  if(earthGravity && combo == false) {
    noStroke();
    mercury.display(true); 
    earth.display(true);
    mars.display(true);
    saturn.display(true);
    sun.display();
  }
  
  if(magnetForce && combo == false) {
    image(magnetic, magnet1.position.x-magnet1.size/2, magnet1.position.y-magnet1.size/2);
    image(magnetic, magnet2.position.x-magnet2.size/2, magnet2.position.y-magnet2.size/2);
    magnet1.addText(magnet1.position.x - magnet1.size/4 + 1, magnet1.position.y - magnet1.size + 5, 1);
    magnet2.addText(magnet2.position.x - magnet2.size/2, magnet2.position.y - magnet2.size + 5, 2);
    
    image(magnetic2, magnet3.position.x-magnet3.size/2, magnet3.position.y-magnet3.size/2);
    magnet3.addText(magnet3.position.x - magnet3.size/2 + 12, magnet3.position.y - magnet3.size + 5, 1);
  
    image(magnetic2, magnet4.position.x-magnet4.size/2, magnet4.position.y-magnet4.size/2);
    magnet4.addText(magnet4.position.x - magnet4.size/2, magnet4.position.y - magnet4.size + 5, 2);
  }
  
  if(combo) {
    sun.display();
    image(magnetic, magnet1.position.x - magnet1.size/2, magnet1.position.y-magnet1.size/2);
    image(magnetic, magnet2.position.x-magnet2.size/2, magnet2.position.y-magnet2.size/2);
    magnet1.addText(magnet1.position.x - magnet1.size/4 + 1, magnet1.position.y - magnet1.size + 5, 1);
    magnet2.addText(magnet2.position.x - magnet2.size/2, magnet2.position.y - magnet2.size + 5, 2);
  }
  
  orbs.applyForce(new PVector(0,0));
  orbs.display();
  
    
  if(moving && combo) {
    orbs.display(true); //display with trail
    noStroke();
    
    orbs.applyOrbitOrbs(GRAVITY);
    orbs.applyGravityPlanetEarth(sun, GRAVITY, 20, 50);
    orbs.applyGravityOrbs(GRAVITY); // adding gravity forces
    
    orbs.checkGas();
    orbs.applyJet(1, AIR_PRESSURE);
    stroke(1); // adding jet forces
    
    orbs.applyMagnet(magnet1, MAGNET_CONST, 1, 0.2);
    orbs.applyMagnet(magnet2, MAGNET_CONST, 2, 0.2); // adding magnetic forces
    
    orbs.run(false, DAMPENING); // run the orbs
  }
  
  if(moving && combo == false) {
    if(earthGravity) {
      mercury.applyForce(mercury.getOrbitForce(mercury.getGravity(sun, GRAVITY, 10, 50)));
      mercury.applyGravityPlanetEarth(sun, GRAVITY, 10, 50);
      mercury.run(false, DAMPENING);
      
      earth.applyForce(earth.getOrbitForce(earth.getGravity(sun, GRAVITY, 10, 50)));
      earth.applyGravityPlanetEarth(sun, GRAVITY, 10, 50);
      earth.run(false, DAMPENING);
      
      mars.applyForce(mars.getOrbitForce(mars.getGravity(mars, GRAVITY, 10, 50)));
      mars.applyGravityPlanetEarth(sun, GRAVITY, 10, 50);
      mars.run(false, DAMPENING);
      
      saturn.applyForce(saturn.getOrbitForce(saturn.getGravity(sun, GRAVITY, 10, 50)));
      saturn.applyGravityPlanetEarth(sun, GRAVITY, 10, 50);
      saturn.run(false, DAMPENING);
      
      orbs.run(false, DAMPENING);
      stroke(1);
    }
    
    if(springForce) {
      orbs.display();
      orbs.applySprings(SPRING_LENGTH, SPRING_CONST);
      
      orbs.run(false, DAMPENING);
    }
    
    if(jetForce) {
      noStroke();
      orbs.display(true);
      orbs.checkGas();
      orbs.applyJet(1, AIR_PRESSURE);
      orbs.run(true, DAMPENING);
      stroke(1);
    }
    
    if(magnetForce) {
      orbs.applyMagnet(magnet1, MAGNET_CONST, 1, 1);
      orbs.applyMagnet(magnet2, MAGNET_CONST, 2, 1);
      orbs.applyMagnet(magnet3, MAGNET_CONST, 1, 1);
      orbs.applyMagnet(magnet4, MAGNET_CONST, 2, 1);
      orbs.run(true, DAMPENING);
      
      magnet3.run(true, DAMPENING);
      magnet3.applyForce(magnet3.getMagnet(magnet1, MAGNET_CONST, 1, 1));
      magnet3.applyForce(magnet3.getMagnet(magnet2, MAGNET_CONST, 2, 1));
      magnet3.applyForce(magnet3.getMagnet(magnet4, MAGNET_CONST, 2, 1));
      
      magnet4.run(true, DAMPENING);
      magnet4.applyForce(magnet4.getMagnet(magnet1, MAGNET_CONST, 1, 1));
      magnet4.applyForce(magnet4.getMagnet(magnet2, MAGNET_CONST, 2, 1));
      magnet4.applyForce(magnet4.getMagnet(magnet3, MAGNET_CONST, 1, 1));
    }
  }
}

void reset() {
  moving = false;
  bounce = false;
  earthGravity = false;
  jetForce = false;
  magnetForce = false;
  combo = false;
  
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
  if(key == 'r') {
    reset();
  }
  if(key == '1') {
    setupEarthGravity();
  }
  if(key == '2') {
    setupSprings();
  }
  if(key == '3') {
    setupJet();
  }
  if(key == '4') {
    setupMagnet();
  }
  if(key == '5') {
    setupCombo();
  }
}

void setupCombo() {
  moving = false;
  bounce = false;
  earthGravity = true;
  springForce = false;
  jetForce = true;
  magnetForce = true;
  combo = true;
  
  orbs = new OrbList();  
  
  sun = new FixedOrb(width/2, height/2, 100, 2000, #FFEB36);
  magnet1 = new FixedOrb(35, height/2, 50, 50, color(255, 0, 0, 50), random(7, 10));
  magnet2 = new FixedOrb(width - 35, height/2, 50, 50, color(255, 0, 0, 50), random(7, 10));
  
  int NUM_ORBS = 5;
  int y = 65;
  for(int i=0; i<NUM_ORBS; i++) {
    float mass = int(random(MIN_MASS, MAX_MASS));
    OrbNode o = new OrbNode( width/2 , y , 25, mass, 
      random(7, 10), random(1, 2), random(1, 2),
      new Engine(750, random(0.5, 2) * 7, random(1,10) / 175));
    orbs.addFront(o);
    if(i==2) {
      y+=150;
    }
    y += 70;
  }
  
}

void setupMagnet() {
  moving = false;
  bounce = true;
  earthGravity = false;
  springForce = false;
  jetForce = false;
  magnetForce = true;
  combo = false;
  
  orbs = new OrbList();
  
  magnet1 = new FixedOrb(width/4-35, height/2, 50, 50, color(255, 0, 0, 50), random(7, 10));
  magnet2 = new FixedOrb(width/4*3-35, height/2, 50, 50, color(255, 0, 0, 50), random(7, 10));
  magnet3 = new Orb(int(random(0,width)), int(random(0, height)), 
    50, 50, random(7, 10), 0.5, 0.5);
  magnet4 = new Orb(int(random(0,width)), int(random(0, height)), 
    50, 50, random(7, 10), 0.5, 0.5);
  
  int NUM_ORBS = 8;
  int y = 65;
  for(int i=0; i<NUM_ORBS; i++) {
    int mass = int(random(MIN_MASS, MAX_MASS));
    color c = color(int(random(0,255)), int(random(0,255)), int(random(0,255)));
    OrbNode o = new OrbNode(int(random(35,width-35)), y, 25, mass, c, 1, random(3,8));
    orbs.addFront(o);
    y += 70;
  }
}

void setupJet() {
  moving = false;
  bounce = true;
  earthGravity = false;
  springForce = false;
  jetForce = true;
  magnetForce = false;
  combo = false;
  
  orbs = new OrbList();
  
  int NUM_ORBS = 8;
  int x = 50;
  for(int i=0; i<NUM_ORBS; i++) {
    OrbNode o = new OrbNode( x, height - 14 , 25, 5, 
      new Engine(int(random(250, 1000)), random(0.5, 2), random(1,10) / 100 ));
    x += width/NUM_ORBS;
    o.velocity.x = random(-1,1);
    o.velocity.y = -1 * random(0,1);
    orbs.addFront(o);
  } 
}

void setupSprings() {
  moving = false;
  bounce = false;
  earthGravity = false;
  springForce = true;
  jetForce = false;
  magnetForce = false;
  combo = false;
  
  orbs = new OrbList();
  
  OrbNode o1 = new FixedOrb(width-15, height/2, 25, 25, color(0));
  orbs.addFront(o1);
  
  for(int i=0; i<NUM_ORBS; i++) {
    OrbNode o = new OrbNode( int(random(15, width-15)), int(random(15, height-15)), 25, 5);
    orbs.addFront(o);
  }
  
  OrbNode o2 = new FixedOrb(15, height/2, 25, 25, color(0));
  orbs.addFront(o2);
  
}

void setupEarthGravity() {
  moving = false;
  bounce = false;
  earthGravity = true;
  springForce = false;
  jetForce = false;
  magnetForce = false;
  combo = false;
  
  orbs = new OrbList(); 
   
  mercury = new OrbNode(width/2, height/3 + 20, 15, 350, #767573, 5);
  earth = new OrbNode(width/2, height/4, 40, 500, #367AEA, 7);
  mars = new OrbNode(width/2, height/15, 25, 450, #C1440E, 7);
  saturn = new OrbNode(width/2, height/50, 60, 650, #937D0C, 10);
  sun = new FixedOrb(width/2, height/2, 100, 1500, #FFEB36);
  
  int NUM_ORBS = 0;
  int y = 35;
  for(int i=0; i<NUM_ORBS; i++) {
    int mass = int(random(MIN_MASS, MAX_MASS));
    OrbNode o = new OrbNode(width/2, y, 25, mass, color(0));
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
  rect(0, 0, 54, 20);
  c = earthGravity ? color(0, 255, 0) : color(255, 0, 0);
  fill(c);
  rect(55, 0, 105, 20);
  c = springForce ? color(0, 255, 0) : color(255, 0, 0);
  fill(c);
  rect(161, 0, 100, 20);
  c = jetForce ? color(0, 255, 0) : color(255, 0, 0);
  fill(c);
  rect(262, 0, 73, 20);
  c = magnetForce ? color(0, 255, 0) : color(255, 0, 0);
  fill(c);
  rect(336, 0, 59, 20);
  c = combo ? color(0, 255, 0) : color(255, 0, 0);
  fill(c);
  rect(396, 0, 100, 20);
  stroke(0);
  fill(0);
  text("MOVING", 1, 0);
  text("EARTH GRAVITY", 56, 0);
  text("SPRING FORCE", 161, 0);
  text("JET FORCE", 262, 0);
  text("MAGNET", 336, 0);
  text("COMBINATION", 400, 0);

}
