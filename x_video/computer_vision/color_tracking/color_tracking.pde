//tuto : https://www.youtube.com/watch?v=nCVZHROb_dE&list=PLRqwX-V7Uu6aG2RJHErXKSWFDXU4qo_ro&index=2&t=636s
import processing.video.*;
Capture cam;
float r2=0, v2=255, b2=0;
float seuil = 10;

void setup() {
  size(640, 480);
  cam = new Capture(this, width, height);
  cam.start();
}

void captureEvent(Capture cam) {
  cam.read();
}
void draw() {
  cam.loadPixels();
  image(cam, 0, 0);
  
  float best = 500;
  int bestX = 0;
  int bestY = 0;
  
  for (int x = 0; x < cam.width; x ++ ) {
    for (int y = 0; y < cam.height; y ++ ) {
      int loc = x + y*cam.width;
      
      color couleur = cam.pixels[loc];
      float r1 = red(couleur);
      float v1 = green(couleur);
      float b1 = blue(couleur);    
      float d = dist(r1, v1, b1, r2, v2, b2);
      
      if ( d < best){
        best = d;
        bestX = x;
        bestY = y;
      }

    }
  }
  
  if(best < seuil){
    fill(r2, v2, b2);
    noStroke();
    ellipse(bestX,bestY, 50,50);
  }
}

void mousePressed(){
  color c = get(mouseX,mouseY);
  r2 = red(c);
  v2 = green(c);
  b2 = blue(c);
}
