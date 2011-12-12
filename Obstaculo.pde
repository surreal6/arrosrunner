class Obstaculo {
  int x, y, w, h;

  Obstaculo(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void display() {
    stroke(#ff0000);
    fill(255);
    rect(x,y,w,h);
  }
  
  boolean colision(Prota p) {
    if (p.position.x > x && p.position.x < x+w && p.position.y > y && p.position.y < y+w) return true;
    else return false;   
  }
   
} 
