class Plataforma {
  int x, y, w, h;

  Plataforma(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void display() {
    stroke(#000000);
    fill(100,100);
    rect(x,y,w,h);
  }

  boolean below(Prota p) {
    if (p.position.x > x && p.position.x < x+w && abs(p.position.y-y) < p.s/2) return true;
    else return false;   
  }

}


