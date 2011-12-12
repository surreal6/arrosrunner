class Punto {
  int x, y, w, h;
  Boolean visible;

  Punto(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    visible = true;
  }
  
  void display() {
    if (visible){
      stroke(#000000);
      fill(255, 255, 0);
      ellipse(x,y,w,h);
  }
  }
  
  boolean colision(Prota p) {
    if (abs(p.position.x - x) < p.s && abs(p.position.y - y) < p.s && visible) return true;
    else return false;   
  }
   
} 
