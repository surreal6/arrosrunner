class Prota {
  
  //desplazamiento del centro del sprite
  int offset_X = -55; 
  int offset_Y = -70;
  //tamaño en pixels (para las c)
  int s = 60;
  int salto = -screenYW/7;
  //contadores de frames para pasos, salto, y dos idle
  int walkFrame = 0;
  int jumpFrame = 0;
  int idleFrame = 0;
  int idle2Frame = 0;
  //contador de idle para ver cuando pasa a idle2
  int idle_n = 0;
  Boolean idle2 = false;
  Boolean walking = true;
  //coordenadas y velocidad en 2 ejes
  PVector oldposition, position, velocity; 
  //sprites del prota 
  PImage [] protacorre, protaidle, protaidle2, protasalta;
  // puntuacion
  int puntos;

  //constructor
  Prota () {
    position = new PVector();  //se inicializan la posicion y velocidad
    oldposition = new PVector();
    velocity = new PVector();
    cargasprites();
    reset();
  }
  
  void reset() { 
    position.x = screenXW/2;
    position.y = suelo;
    velocity.x = 0;
    velocity.y = 0;
    puntos = 0;
  }

 void display() {
   //segun que accion esta haciendo, se pinta un sprite u otro
    if (walking && velocity.x != 0) pintacamina();
    if (walking && velocity.x == 0) pintaidle();
    if (walking == false) pintasalta();
    pintaguias();
  }
  
  void mover() {
    //guardamos la posicion anterior (por si acaso luego en las colisiones hace falta)
    oldposition.x = position.x;
    oldposition.y = position.y;
    contadores(); //para mostrar en secuencia los sprites
    //saltar
    saltar();
    //calculos de velocidad
    velocity.x =+ (mouseX-screenXW/2)/3;  //luego se sustituye el raton por el acelerometro
    position.add(velocity);
    //frenando la velocidad en x a un maximo
    if (velocity.x > 20) velocity.x = 20;
    if (velocity.x < -20) velocity.x = -20; 
    //simulando gravedad cuando cae
    if (position.y < suelo) velocity.y +=world.gravity;
    //correcciones de posicion
        //cambiando el suelo segun las plataformas
    suelo = world.horizonte;
    for(Plataforma p: world.plataformas){
      if (p.below(this) && position.y >= p.y && suelo > p.y) suelo = p.y;
      //molaria refinar esto para que calcule el grosor de la plataforma, porque a mucha velocidad, se lo salta
    }
        
    //rebotando
    for(Obstaculo p: world.obstaculos){
      if (p.colision(this)) {
        //velocity.x = -velocity.x;
        position.x = oldposition.x;
        position.y = oldposition.y;
      }
    }
    
    //buscando puntos
    for(Punto p: world.puntos){
      if (p.colision(this)) {
        puntos += 1;
        p.visible = false;
      }
    }
    
      //evitando que baje del suelo
    if (position.y >= suelo) {
      if (velocity.y > 0) velocity.y = 0;
      position.y = suelo;
      walking = true;
      jumpFrame = 0;   //si toca el suelo acaba el salto
    } 
    //println("vel: "+velocity.x+","+velocity.y+" pos: "+position.x+","+position.y+" suelo "+suelo);
    println(puntos);
  }
  
    void saltar(){
    if (walking == false && position.y <= suelo) { 
      if (jumpFrame == 0) velocity.y=salto;
    jumpFrame++;
      if (jumpFrame >24) {
        jumpFrame = 0;
        walking = true;
      }
    }  
  }
  
//
// CONTADOR de sprites para las acciones
//
  
  void contadores(){
    if (walking){
      //caminar 
      if (velocity.x != 0) {
        if (velocity.x > 0) walkFrame++;  //hacia adelante
        if (velocity.x < 0) walkFrame--;  //hacia atras
        if (walkFrame > 11) walkFrame = 0;   //y en bucle
        if (walkFrame < 0) walkFrame = 11;
      } 
      //idle 1
      if (velocity.x == 0 && idle2 == false) {
        idleFrame++;
        if (idleFrame > 11) {
          idleFrame = 0;
          idle_n ++;   //cuando se repite idle 10 veces, salta idle2
          if (idle_n > 10) {
            idle_n=0;
            idle2 = true;
          }
        }
      } 
      //idle2
      else if (velocity.x == 0 && idle2){
        idle2Frame++;
        if (idle2Frame > 17) {
          idle2Frame = 0;
          idle2 = false;
        }
      }
    }  
  }
  
//
//DISPLAYS
//
  
  void pintacamina(){
  pushMatrix();
      translate(position.x, position.y);
      // pinta hacia la izquierda o derecha segun hacia donde avanza
      if (velocity.x > 0) image(protacorre[walkFrame], offset_X, offset_Y);
      else {
        //mirror al sprite
        pushMatrix();
        scale(-1.0, 1.0);
        image(protacorre[walkFrame], offset_X, offset_Y);
        popMatrix();
      }
      popMatrix(); 
  }
  
  void pintaidle(){
    pushMatrix();
    translate(position.x, position.y);
    if (idle2) image(protaidle2[idle2Frame], offset_X, offset_Y);
    else image(protaidle[idleFrame], offset_X, offset_Y);
    popMatrix(); 
  }
  
  void pintasalta(){
    pushMatrix();
    translate(position.x, position.y);
    // pinta hacia la izquierda o derecha segun hacia donde avanza
    if (velocity.x > 0) image(protasalta[jumpFrame], offset_X, offset_Y);
    else {
      //mirror al sprite
      pushMatrix();
      scale(-1.0, 1.0);
      image(protasalta[jumpFrame], offset_X, offset_Y);
      popMatrix();
    }
    popMatrix();
  }
  
  void pintaguias(){
      pushMatrix();
      stroke(#00bb00);
      noFill();
      rect(0,world.horizonte,screenXW,1);
      rect(0,0,position.x,position.y);
      translate(position.x, position.y);
      stroke(#bbbb00);
      ellipse(0,-s/2,s,s);
      ellipse(0,-s/2,s/2,s);
      noFill();
      popMatrix(); 
  }
  
//
//cargar sprites
//
  void cargasprites(){
    //cargando los sprites
    protacorre = new PImage[12];
    for (int i = 0; i < protacorre.length; i++) {
      protacorre[i] = loadImage("achi/achicorre_"+ (i+1) + ".png");
    }
    protaidle = new PImage[12];
    for (int i = 0; i < protaidle.length; i++) {
      protaidle[i] = loadImage("achi/achiidle_"+ (i+1) + ".png");
    }
    protaidle2 = new PImage[18];
    for (int i = 0; i < protaidle2.length; i++) {
      protaidle2[i] = loadImage("achi/achiidle2_"+ (i+1) + ".png");
    }
    protasalta = new PImage[25];
    for (int i = 0; i < protasalta.length; i++) {
      protasalta[i] = loadImage("achi/achisalta_"+ (i+1) + ".png");
    }
    reset();
  }


}

