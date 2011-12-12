class World {
  
  //los sprites del mundo
  PImage backg, backg2;
  
  int offset_world = 0;    //no estoy seguro de porque esta esto aquí
  int worldlenght = 1160;  //largo en pixeles del nivel
  
  
  int horizonte = int(screenYW*0.94);  //altura del horizonte, proporcional al alto de pantalla. 
  int gravity = 9;
  
  ArrayList<Plataforma> plataformas = new ArrayList<Plataforma>(); //un array de plataformas
  ArrayList<Obstaculo> obstaculos = new ArrayList<Obstaculo>(); //un array de obstaculos
  ArrayList<Punto> puntos = new ArrayList<Punto>(); //un array de objetos que dan puntos (estrellas, setas, ingredientes)
  
  // constructors
  World() {
    backg = loadImage("worldcycle1.png");
    backg2 = loadImage("worldcycle2.png");
    suelo = horizonte;
    crear_plataformas();
    crear_obstaculos();
    crear_puntos();
  }
  
  void display(Prota prota) {
    float vueltas = floor(prota.position.x / worldlenght);
    float resto = (prota.position.x/worldlenght - vueltas);
    //println ("Vueltas: "+vueltas+" resto: "+resto);

    pushMatrix();
    pintamundo(resto);
    popMatrix();
  }
  
  void pintamundo(float resto){
    //pinta un mundo a continuación del otro cuando el jugador se acerca al final, para que no salte el bucle
    //cuando va hacia atras 
    
    //hay que rehacer el pintamundo, eliminando el valor ese de offset y pintando los obstaculos y puntos
    //se pinta un mundo y un segundo mundo que sirva de empalme (del ancho de la pantalla)
    
    image(backg2, 0 + offset_world, 0, worldlenght, screenYW);
    
    drawPlataformas();
    drawObstaculos();
    drawPuntos();
    
    if (resto > 0.5) image(backg2, worldlenght + offset_world, 0, worldlenght, screenYW);
    if (resto < 0.5) {
      image(backg2, -worldlenght + offset_world, 0, worldlenght, screenYW);
      image(backg2, worldlenght + offset_world, 0, worldlenght, screenYW);
    }
  }
 
  void crear_plataformas(){
    Plataforma p1 = new Plataforma(0,130, 500, 20);
    Plataforma p2 = new Plataforma(800,50, 50,20);
    Plataforma p3 = new Plataforma(800,180, 120, 20);
    plataformas.add( p1 );
    plataformas.add( p2 );
    plataformas.add( p3 );
  }
  
  void drawPlataformas() {
    for(Plataforma p: plataformas){
      p.display();
    }
  }
    
  void crear_obstaculos(){
    Obstaculo p1 = new Obstaculo(100,280, 200, 50);
    Obstaculo p2 = new Obstaculo(680,280, 50,50);
    Obstaculo p3 = new Obstaculo(300,180, 50, 50);
    Obstaculo p4 = new Obstaculo(1200,180, 50, 50);

    obstaculos.add( p1 );
    obstaculos.add( p2 );
    obstaculos.add( p3 );
    obstaculos.add( p4 );
  }
  
  void drawObstaculos() {
    for(Obstaculo p: obstaculos){
      p.display();
    }
  }
  
  void crear_puntos(){
    Punto p1 = new Punto(800,275, 50, 50);
    Punto p2 = new Punto(900,275, 50,50);
    Punto p3 = new Punto(1000,300, 50, 50);
    Punto p4 = new Punto(1200,275, 50, 50);

    puntos.add( p1 );
    puntos.add( p2 );
    puntos.add( p3 );
    puntos.add( p4 );
  }
  
  void drawPuntos() {
    for(Punto p: puntos){
      p.display();
    }
  }
  

}

