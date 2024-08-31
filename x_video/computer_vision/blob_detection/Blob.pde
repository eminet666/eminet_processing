class Blob {
 float minx, maxx, miny, maxy;
 
 Blob(float x, float y) {
    minx = x; maxx = x;
    miny = y; maxy = y;
 }
 
 void show() {
   noStroke();
   fill(255);
   rectMode(CORNERS);
   rect(minx, miny, maxx, maxy);
   
 }
 
 void add(float x, float y){
   minx = min(minx, x);
   miny = min(miny, y);
   maxx = max(maxx, x);
   maxy = max(maxy, y);   
   
 
 }
 
 float size() {
   return (maxx-minx)*(maxy-miny);
 }
 
 boolean isNear(float x, float y) {
   float cx = (minx + maxx)/2;
   float cy = (miny + maxy)/2;
   
   float d = distSq(cx, cy, x, y);
   if (d < dist_seuil*dist_seuil) {
       return true; 
     } else {
       return false;
     }
 
 }
 
 
}
