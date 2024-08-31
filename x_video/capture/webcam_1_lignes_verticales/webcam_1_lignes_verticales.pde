import processing.opengl.*;
import codeanticode.gsvideo.*;

GSCapture capture;
int captureL = 160;       // largeur video
int captureH = 120;       // hauteur video

int screenL = 640;        // largeur video
int screenH = 480;        // hauteur video
int bgcolor = 255;      // couleur de fond

int pas = 1;           // unité de la grille = nb pixels capture
int homothetie = screenL/captureL ;
int module = pas*homothetie;
color Colors[];        // tableau des couleurs collectées


public void setup() {
  size(screenL, screenH, P2D);
  // Or run full screen, more fun! Use with Sketch -> Present
  //size(screen.width, screen.height, OPENGL);

  capture = new GSCapture(this, captureL, captureH);
  capture.start(); 
  Colors = new color[captureL/pas*captureH/pas]; 
}


public void captureEvent(GSCapture capture) {
  capture.read();
}


void draw() {
  //image(capture, 0, 0, width, height);

  noStroke();            // bordure ou pas
  capture.loadPixels();    // capture des pixel de la frame
  
  // parametres de la boucle (pour ne faire le calcul qu'une fois)
  int iMax = captureL/pas;
  
  // boucle sur les pixels capturés (pixel du milieu H de ligne)
  for (int i = 0; i < iMax; i++) {
      Colors[i] = capture.get(i*pas, captureH/2);
      //println(movie.get(i,j));
      fill(Colors[i]);
      rect(i*module, 0, module, screenH);
  }
  
}
