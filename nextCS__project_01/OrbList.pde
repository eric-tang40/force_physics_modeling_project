class OrbList {

  OrbNode front;

  OrbList() {
    front = null;
  }//constructor
  
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
