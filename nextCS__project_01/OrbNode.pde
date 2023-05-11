class OrbNode extends Orb {
  OrbNode next;
  OrbNode previous;

  OrbNode(int x, int y, int s, float m) {
    super(x, y, s, m);
  }//constructor
  
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
      }//draw spring
      stroke(0); 
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

}//class OrbNode
