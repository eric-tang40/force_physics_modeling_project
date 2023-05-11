class FixedOrb extends OrbNode {

  FixedOrb(int x, int y, int s, float m) {
    super(x, y, s, m);
    c = color(0);
  }//constructor
  
  FixedOrb(int x, int y, int s, float m, color initColor) {
    super(x, y, s, m);
    c = initColor;
  }//constructor

  //fixed orbs do not move at all
  void run(boolean bounce, float damp) {
  }//run

  //dont do the transparency/denisity calculation
  void display() {
    fill(c);
    circle(position.x, position.y, size);
  }//display

}//FixedOrb
