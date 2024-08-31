class Blob {
 float minx, maxx, miny, maxy;
 ArrayList<PVector> points;
 int id = 0;
 boolean taken = false;
 
 Blob(float x, float y) {
   minx = x; maxx = x;
   miny = y; maxy = y;
   points = new ArrayList<PVector>();
   points.add(new PVector(x,y));
 }
 
 void show() {
   noStroke();
   fill(255);
   rectMode(CORNERS);
   rect(minx, miny, maxx, maxy);
   
   textAlign(CENTER);
   textSize(64);
   fill(0);
   text(id, minx + (maxx-minx)/2, maxy-10);
   
 }
 
 void add(float x, float y){
   points.add(new PVector(x,y));
   minx = min(minx, x);
   miny = min(miny, y);
   maxx = max(maxx, x);
   maxy = max(maxy, y);   
 }
 
 void become(Blob other){
   minx = other.minx;
   miny = other.miny;  
   maxx = other.maxx;
   maxy = other.maxy;    
 }
 
 
 float size() {
   return (maxx-minx)*(maxy-miny);
 }
 // coordonnées du centre du blog
 PVector getCenter() {
   float x = (maxx-minx)/2 +minx;
   float y = (maxy-miny)/2 +miny;
   return new PVector(x,y);
 }
  
 
 boolean isNear(float x, float y) {
   //float cx = max(min(x, maxx), minx);  
   //float cy = max(min(y, maxy), miny);   
   //float d = distSq(cx, cy, x, y);
   float d = 10000000;
   for(PVector v : points) {
     float tempD = distSq(x, y, v.x, v.y);
     if(tempD < d) { d = tempD; }
   }
   
   if ( d < dist_seuil*dist_seuil) {
     return true; 
   } else {
     return false;
   }
 
 }
 
}
