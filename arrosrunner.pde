int walkFrame = 0; 
int spitFrame = 0; 
int counter = 0; 
int salto = 0;
int cameraoffset_X, cameraoffset_Y, margen, suelo;
int screenXW = 480;
int screenYW = 320;

Prota achi;
World world;

void setup() {
  size(480, 320);
  frameRate(25);
  achi = new Prota();
  world = new World();
  suelo =  world.horizonte;
  cameraoffset_X = 0;
  cameraoffset_Y = 0;
}
  
void draw() {
  background(0);
  pushMatrix();
  translate(-cameraoffset_X, cameraoffset_Y);
  world.display(achi);  
  achi.display();
  popMatrix();
  achi.mover();
  offset_camera(); 
}

void offset_camera(){
  // offset de la camara segun velocidad de achi
  // molaria hacer este offset mas elastico...
  int margen = int(achi.velocity.x);
  if (achi.velocity.x > 20) margen = 20; 
  if (achi.velocity.x < -20) margen = -20;
  if (int(achi.position.x) > world.worldlenght) achi.position.x = 0;
  if (int(achi.position.x) < 0) achi.position.x = world.worldlenght;
  cameraoffset_X = int(achi.position.x)-screenXW/2 + 8*margen;
  //println("cameraoffset: "+cameraoffset_X);
}

void mousePressed(){
  if (achi.walking == true) {
    achi.walking = false;
  }
}  

                                     

