class OrbList {

  OrbNode front;

  OrbList() {
    front = null;
  }//constructor
  
  void applyMagnet(Orb magnet, float m, int dir, float restraint1) {
    OrbNode current = front;
    while (current != null) {
      current.applyMagnet(magnet, m, dir, restraint1);
      current = current.next;
    }
  }
  
  void applyJet(float flow, float air) {
    OrbNode current = front;
    while (current != null) {
      current.applyJet(flow, air);
      current = current.next;
    }
  }

  void checkGas() {
    OrbNode current = front;
    while (current != null) {
      current.checkGas();
      current = current.next;
    }
  }
  
  void applyGravityPlanetEarth(Orb o, float G, int r1, int r2) {
    OrbNode current = front;
    while (current != null) {
      current.applyGravityPlanetEarth(o, G, r1, r2);
      current = current.next;
    }
  }
  
  void applyOrbitOrbs(float G) {
    OrbNode current = front;
    while (current != null) {
      PVector f = current.getOrbitForce(current.getGravity(sun, G, 10, 50));
      current.applyForce(f);
      current = current.next;
    }
  }
  
  void applyGravityOrbs(float G) {
    OrbNode current = front;
    while (current != null) {
      current.applyGravityOrbs(G);
      current = current.next;
    }
  }
  
  void applyGravityPlanet(Orb o, float G) {
    OrbNode current = front;
    while (current != null) {
      current.applyGravityPlanet(o, G);
      current = current.next;
    }
  }
  
  void applySprings(int springLength, float springK) {
    OrbNode current = front;
    while (current != null) {
      current.applySprings(springLength, springK);
      current = current.next;
    }
  }//applySprings
  
  void addFront(OrbNode o) {
    if(front == null) {
      front = o;
    }
    else {
      front.previous = o;
      o.next = front;
      front = o;
    }
  }//addFront
  
  void display() {
    OrbNode current = front;
    while (current != null) {
      current.display();
      current = current.next;
    }
  }
  
  void display(boolean trail) {
    OrbNode current = front;
    while (current != null) {
      current.display(trail);
      current = current.next;
    }
  }
  
  void run(boolean bounce, float damp) {
    OrbNode current = front;
    while (current != null) {
      current.run(bounce, damp);
      current = current.next;
    }
  }//applySprings
  
  void applyForce(PVector f) {
    OrbNode current = front;
    while (current != null) {
      current.applyForce(f);
      current = current.next;
    }
  }

  void removeFront() {
    front = front.next;
  }//removeFront

}//OrbList
