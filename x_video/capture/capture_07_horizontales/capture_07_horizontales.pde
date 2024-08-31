import processing.video.*;
Capture video;

int pointillize = 16;

void setup() {
  size(640, 480);
  background(0);
  video = new Capture(this, width, height);
  video.start();
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {

  // Pick a random point
  int x = int(random(video.width));
  int y = int(random(video.height));
  int loc = x + y*video.width;
  
  // Look up the RGB color in the source image
  video.loadPixels();
  float r = red(video.pixels[loc]);
  float g = green(video.pixels[loc]);
  float b = blue(video.pixels[loc]);
  noStroke();
  // Draw an ellipse at that location with that color
  fill(r, g, b, 100);
  ellipse(x, y, pointillize, pointillize); // Back to shapes! Instead of setting a pixel, we use the color from a pixel to draw a circle.
}

// ------------
import processing.opengl.*;
import codeanticode.gsvideo.*;

GSCapture capture;
int captureL = 160;       // largeur video
int captureH = 120;       // hauteur video

int screenL = 640;        // largeur video
int screenH = 480;        // hauteur video
int bgcolor = 255;      // couleur de fond

int pas = 2;           // unité de la grille = nb pixels capture
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
  int jMax = captureH/pas;
  
  // boucle sur les pixels capturés (pixel du milieu de ligne)
  for (int j = 0; j < jMax; j++) {
      Colors[j] = capture.get(captureL/2, j*pas);
      //println(movie.get(i,j));
      fill(Colors[j]);
      rect(0,j*module,screenL,module);
  }
  
}
