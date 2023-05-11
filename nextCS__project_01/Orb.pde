class Orb {

  PVector position;
  PVector velocity;
  PVector acceleration;
  int size;
  float mass;
  color c;

  Orb(int x, int y, int s, float m) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    size = s;
    mass = m;
    c = color(random(256), random(256), random(256));
  }//constructor
  
  Orb(int x, int y, int s, float m, color initColor) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    size = s;
    mass = m;
    c = initColor;
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
  
  PVector getGravity(Orb o, float G) {
    if (o != this) {
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
  
  void moveInCircle(float radius) {
    float deltaX = cos(angle) * radius;
    float deltaY = sin(angle) * radius;
    position.x += deltaX;
    position.y += deltaY;
    
    angle += radians(60)/10;
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
  }//applyForce
  

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
  }//display
  
}
