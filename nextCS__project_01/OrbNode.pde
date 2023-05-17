class OrbNode extends Orb {
  OrbNode next;
  OrbNode previous;

  OrbNode(int x, int y, int s, float m) {
    super(x, y, s, m);
  }//constructor
  
  OrbNode(int x, int y, int s, float m, color initColor) {
    super(x, y, s, m);
    c = initColor;
  }//constructor
  
  OrbNode(int x, int y, int s, float m, color initColor, float initVelo) {
    super(x, y, s, m);
    c = initColor;
    velocity = new PVector(initVelo, 0);
  }//constructor
  
  OrbNode(int x, int y, int s, float m, color initColor, float initVelo, float ch) {
    super(x, y, s, m);
    c = initColor;
    velocity = new PVector(initVelo, 0);
    charge = ch;
  }//constructor
  
  OrbNode(int x, int y, int s, float m, Engine initE) {
    super(x, y, s, m, initE);
  }
  
  OrbNode(int x, int y, int s, float m, float initMag, float initVeloX, float initVeloY, 
    Engine initE) {
      super(x, y, s, m, initMag, initVeloX, initVeloY, initE);
    }
  
  void display() {
    super.display();
    
    if(springForce) {
      if (next != null) {
        float d = this.position.dist(next.position);
        if (d > SPRING_LENGTH) {
          stroke(0, 255, 0);
        }//extended spring
        else if (d < SPRING_LENGTH) {
          stroke(255, 0, 0);
        }//compressed spring
        else {
          stroke(0);
        }//just right spring
        line(this.position.x, this.position.y, next.position.x, next.position.y);
        if(previous != null) {
          float e = this.position.dist(next.position);
          if (e > SPRING_LENGTH) {
            stroke(0, 255, 0);
          }//extended spring
          else if (e < SPRING_LENGTH) {
            stroke(255, 0, 0);
          }//compressed spring
          else {
            stroke(0);
          }//just right spring
          line(this.position.x, this.position.y, previous.position.x, previous.position.y);
        }
      }//draw spring
      stroke(0); 
    }
  }
  
  void applyMagnet(Orb magnet, float m, int dir, float restraint1) {
    if (next != null) {
      PVector s = this.getMagnet(magnet, m, dir, restraint1);
      this.applyForce(s);
    }//there's a next
    else {
      if(previous != null) {
        PVector s = this.getMagnet(magnet, m, dir, restraint1);
        this.applyForce(s);
      }
    }
  }
  
  void applyJet(float flow, float air) {
    if (next != null) {
      PVector s = this.getJet(flow, air);
      this.applyForce(s);
    }//there's a next
    else {
      if(previous != null) {
        PVector s = this.getJet(flow, air);
        this.applyForce(s);
      }
    }
  }
  
  void applySprings(int springLength, float springK) {
    if (next != null) {
      PVector s = this.getSpring(next, springLength, springK);
      this.applyForce(s);
    }//there's a next
    if (previous != null) {
      PVector s = this.getSpring(previous, springLength, springK);
      this.applyForce(s);
    }//there's a previous
  }//applySprings
  
  void applyGravityOrbs(float G) {
    if (next != null) {
      PVector s = this.getGravity(next, G);
      this.applyForce(s);
    }//there's a next
    if (previous != null) {
      PVector s = this.getGravity(previous, G);
      this.applyForce(s);
    }//there's a previous
  }
  
  void applyGravityPlanet(Orb o, float G) {
    PVector s = this.getGravity(o, G);
    this.applyForce(s);
  }
  
  void applyGravityPlanetEarth(Orb o, float G, int r1, int r2) {
    PVector s = this.getGravity(o, G, r1, r2);
    this.applyForce(s);
  }
  
   PVector getGravity(Orb o, float G, int r1, int r2) {
    if (o != this) {
      float d = this.position.dist(o.position);
      d = constrain(d, r1, r2);
      float mag = (G * mass * o.mass) / (d * d);
      PVector direction = PVector.sub(o.position, this.position);
      direction.normalize();
      direction.mult(mag);
      return direction;
    }
    return new PVector(0, 0);
  }//getGravity

}//class OrbNode
