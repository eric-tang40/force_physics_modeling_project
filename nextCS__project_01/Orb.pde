class Orb {

  PVector position;
  PVector velocity;
  PVector acceleration;
  int size;
  float mass;
  color c;
  Engine e;
  ArrayList<PVector> history;
  float charge;
  float magnetism;

  Orb(int x, int y, int s, float m) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    size = s;
    mass = m;
    c = color(random(256), random(256), random(256));
    history = new ArrayList<PVector>();
  }//constructor
  
  Orb(int x, int y, int s, float m, color initColor) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    size = s; 
    mass = m;
    c = initColor;
    history = new ArrayList<PVector>();
  }//constructor
  
  Orb(int x, int y, int s, float m, Engine initE) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    size = s;
    mass = m;
    c = color(random(256), random(256), random(256));
    e = initE;
    history = new ArrayList<PVector>();
  }//constructor
  
  Orb(int x, int y, int s, float m, float initMag, float initVeloX, float initVeloY) {
    position = new PVector(x, y);
    velocity = new PVector(initVeloX, initVeloY);
    acceleration = new PVector(0, 0);
    size = s;
    mass = m;
    c = color(random(256), random(256), random(256));
    history = new ArrayList<PVector>();
    magnetism = initMag;
    charge = random(3,10);
  }//constructor
  
  Orb(int x, int y, int s, float m, float initMag, float initVeloX, float initVeloY, 
    Engine initE) {
    position = new PVector(x, y);
    velocity = new PVector(initVeloX, initVeloY);
    acceleration = new PVector(0, 0);
    size = s;
    mass = m;
    c = color(random(256), random(256), random(256));
    history = new ArrayList<PVector>();
    magnetism = initMag;
    charge = random(3,10);
    e = initE;
  }//constructor
  
  
  void run(boolean bounce, float damp) {
    velocity.add(acceleration);
    velocity.mult(damp);
    position.add(velocity);
    acceleration.mult(0);

    if (bounce) {
      yBounce();
      xBounce();
    }
  }//run
  
  PVector getMagnet(Orb magnet, float m, int dir, float restraint1) {
    float x = charge * velocity.mag();
    float distance = this.position.dist(magnet.position);
    distance = constrain(distance, restraint1, 800.0);
    float field = (m * magnet.magnetism) / (2 * PI * distance);
    PVector direction = velocity.copy();
    direction.normalize();
    if(dir == 1) {  //magnetic field goes into the screen
      direction.rotate(radians(90));
      return direction.mult(x * field);
    }
    if(dir == 2) {  //magnetic field goes out of the screen
      direction.rotate(radians(270));
      return direction.mult(x * field);
    }
    return new PVector(0,0);
  }
  
  PVector getJet(float flow, float air) {
    if(e != null) {
      if(e.gas == 0) {
        return new PVector(0,0);
      }
      else {
        e.gas-= flow;
        float mag = ( flow * e.exhaust ) + ( e.pressure - air ) * e.area;
        e.exhaust += ((e.area / 0.1) / 100) * 2;
        if(velocity.x == 0 && velocity.y == 0) {
          return new PVector(0, -mag);
        }
        else {
          PVector copy = velocity.copy();
          copy = copy.normalize();
          return copy.mult(mag);
        }
      }
    }
    return new PVector(0,0);
  }
  
  void checkGas() {
    if(e != null) {
      if(e.gas <= 0) {
        history = new ArrayList<PVector>();
        fill(255,0,0);
        textSize(10);
        text("Out of Gas", position.x- size/2 - 10, position.y - size);
        fill(c);
      }
    }
  }
  
  PVector getGravity(Orb o, float G) {
    if(o != this) {
      float d = this.position.dist(o.position);
      d = constrain(d, 10, 100);
      float mag = (G * mass * o.mass) / (d * d);
      PVector direction = PVector.sub(o.position, this.position);
      direction.normalize();
      direction.mult(mag);
      return direction;
    }
    return new PVector(0, 0);
  }//getGravity
  
  PVector getOrbitForce(PVector g) {
    g.rotate(QUARTER_PI);
    return g.mult(0.0000001); 
  }
  
  PVector getSpring(Orb o, int springLength, float springK) {
    float d = position.dist(o.position);
    //d = max(5, d);
    float displacement = d - springLength;
    float magnitude = displacement * springK;

    PVector direction = PVector.sub(o.position, this.position);
    direction.normalize();
    direction.mult(magnitude);
    return direction;
  }//getSpring
  
  void applyForce(PVector f) {
    PVector newf = f.copy();
    newf.div( mass );
    acceleration.add(newf);
    
    PVector v = new PVector(position.x, position.y);
    history.add(v);
    if(history.size() > 25) {
      history.remove(0);
    }
  }//applyForce
  
  void addText(float x, float y, int dir) {
    fill(0);
    textSize(15);
    if(dir == 1) {
      text("Into", x, y);
    }
    else if(dir == 2) {
      text("Outward", x, y);
    }
    fill(c);
  }

  void yBounce() {
    if (position.y < size/2) {
      position.y = size/2;
      velocity.y *= -1;
    }
    else if (position.y >= (height-size/2)) {
      position.y = height - size/2;
      velocity.y *= -1;
    }
  }//yBounce

  void xBounce() {
    if (position.x < size/2) {
      position.x = size/2;
      velocity.x *= -1;
    }
    else if (position.x >= width - size/2) {
      position.x = width - size/2;
      velocity.x *= -1;
    }
  }//xBounce
  
    boolean checkYBoundry() {
    boolean check = position.y >= height - size/2;
    check = check || (position.y <= size/2);
    return check;
  }
  boolean checkXBoundry() {
    boolean check = position.x >= width - size/2;
    check = check || (position.x <= size/2);
    return check;
  }
  
  void display() {
    fill(c);
    circle(position.x, position.y, size);
  }

  void display(boolean trail) {
    fill(c);
    circle(position.x, position.y, size);
    
    for(int i=0; i<history.size(); i++) {
      PVector current = history.get(i);
      fill(c, i*20);
      circle(current.x, current.y, size-5);
    }
  }//display
}
