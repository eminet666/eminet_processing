//tuto : https://www.youtube.com/watch?v=r0lvsMPGEoY&list=PLRqwX-V7Uu6aG2RJHErXKSWFDXU4qo_ro&index=6&t=222s
import processing.video.*;
Capture cam;
float r2=0, v2=255, b2=0;
float color_seuil = 10;
float dist_seuil = 25;
float size_seuil = 500;
int blobCounter = 0;

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
  
  ArrayList<Blob> currentBlobs = new ArrayList<Blob>();
  
  //color_seuil = map(mouseX, 0, width, 0, 100);
  // println((color_seuil);
  
  // BOUCLE LECTURE PIXELS
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
        for (Blob b : currentBlobs){
          if(b.isNear(x,y)){
            b.add(x,y);
            found = true;
            break;      
          }         
        }
        if (!found) {
          Blob b = new Blob(x,y);
          currentBlobs.add(b);
        }  
      }
    }
  }
  
  // enlève les blobs trops petits
  for (int i = currentBlobs.size()-1; i >= 0 ; i--){
    if(currentBlobs.get(i).size() < size_seuil){
      currentBlobs.remove(i);
      //b.show();
    }
  }
  
  // PROCESS CURRENT BLOBS
  // 0 _ no blobs
  if (blobs.isEmpty() && currentBlobs.size() > 0){
    for(Blob b : currentBlobs) {
      b.id = blobCounter;
      blobs.add(b);
      blobCounter++;
    }
  } else if (currentBlobs.size() <= blobs.size()) {
    // 1 _ AUTANT OU MOINS
    for(Blob b : blobs) {
      float recordD = 1000;
      Blob matched = null;
      for (Blob cb : currentBlobs) {
        PVector centerB = b.getCenter();
        PVector centerCB = cb.getCenter();
        float d = PVector.dist(centerB, centerCB);
        if (d < recordD && !cb.taken) {
          recordD = d;
          matched = cb;
        }
      }
      matched.taken = true;
      b.become(matched);
    }

    // 2 _ si il y en a plus
    for(Blob b : currentBlobs) {
      if (!b.taken){
        b.id = blobCounter;
        blobs.add(b);
        blobCounter++;
      }
    }  
  } else if (blobs.size() > currentBlobs.size()){
      for (Blob b : blobs){
        b.taken = false;
      }
    
      for(Blob cb : currentBlobs) {
        float recordD = 1000;
        Blob matched = null;
        for (Blob b : blobs) {
          PVector centerB = b.getCenter();
          PVector centerCB = cb.getCenter();
          float d = PVector.dist(centerB, centerCB);
          if (d < recordD && !b.taken) {
            recordD = d;
            matched = b;
          }
        }
        if (matched != null){
          matched.taken = true;
          matched.become(cb);      
        } 
        
      }  
        
        for (int i = blobs.size() - 1; i >= 0; i--){
          Blob b = blobs.get(i);
          if (!b.taken) {
            blobs.remove(i);
          }
        }  
      
  }

 for (Blob b : blobs) {
   b.show();  
 }
  
  // affichage
  textAlign(RIGHT);
  textSize(12);
  fill(0);
  text("color seuil : "+color_seuil,width-10, 30);   
  text("dist seuil : "+dist_seuil,width-10, 50);  
  text("size seuil : "+size_seuil,width-10, 70);
  
  text("currentBlobs size : "+currentBlobs.size(),width-10, 100);  
  text("blobs size : "+blobs.size(),width-10, 120);  
  
}
// -----------------------------------
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
