//tuto : https://www.youtube.com/watch?v=1scFcY-xMrI&list=PLRqwX-V7Uu6aG2RJHErXKSWFDXU4qo_ro&index=5
import processing.video.*;
Capture cam;
float r2=0, v2=255, b2=0;
float color_seuil = 10;
float dist_seuil = 25;
float size_seuil = 500;

ArrayList<Blob> blobs = new ArrayList<Blob>(); // array flexible size

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
  
  blobs.clear();
  
  //color_seuil = map(mouseX, 0, width, 0, 100);
 
  // println((color_seuil);
  
  for (int x = 0; x < cam.width; x ++ ) {
    for (int y = 0; y < cam.height; y ++ ) {
      int loc = x + y*cam.width;
      
      color couleur = cam.pixels[loc];
      float r1 = red(couleur);
      float v1 = green(couleur);
      float b1 = blue(couleur);    
      float d = dist(r1, v1, b1, r2, v2, b2);
      
      if ( d < color_seuil){
        boolean found = false;
        for (Blob b : blobs){
          if(b.isNear(x,y)){
            b.add(x,y);
            found = true;
            break;      
          }         
        }
        if (!found) {
          Blob b = new Blob(x,y);
          blobs.add(b);
        }  
      }

    }
  }
  
  for (Blob b : blobs){
    if(b.size() > size_seuil){
      b.show();
    }
  }
  
}

float distSq(float x1, float y1, float x2, float y2){
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
  return d;
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2){
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) + (z2-z1)*(z2-z1);
  return d;
}

void keyPressed(){
  if (key == 'a') { dist_seuil++; }
  else if (key == 'z') { dist_seuil--; }
  println(dist_seuil);
}

void mousePressed(){
  color c = get(mouseX,mouseY);
  r2 = red(c);
  v2 = green(c);
  b2 = blue(c);
}
