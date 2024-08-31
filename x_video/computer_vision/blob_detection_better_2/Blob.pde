class Blob {
 float minx, maxx, miny, maxy;
 ArrayList<PVector> points;
 
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
   
   for(PVector v : points){
     stroke(0, 0, 255);
     point(v.x, v.y);
   }
   
 }
 
 void add(float x, float y){
   points.add(new PVector(x,y));
   minx = min(minx, x);
   miny = min(miny, y);
   maxx = max(maxx, x);
   maxy = max(maxy, y);   
 }
 
 float size() {
   return (maxx-minx)*(maxy-miny);
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
