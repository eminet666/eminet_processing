// luminosité moyenne

import processing.video.*;
Capture video;

void setup() {
  size(640, 480);
  // Using the default capture device
  video = new Capture(this, width, height);
  video.start();
}

// New frame available from camera
void captureEvent(Capture video) {
  video.read();
}


void draw() {
  background(0);
  image(video, 0, 0);                     
  video.loadPixels();

  float totalBrightness = 0;
  for (int i = 0; i < video.pixels.length; i ++ ) {
    color c = video.pixels[i];

    float luminosite = brightness(c);
    totalBrightness += luminosite;
  }

  float avgBrightness = totalBrightness / video.pixels.length; 
  println(avgBrightness);
  noStroke();
  fill(0);
  float r = avgBrightness;
  ellipse(width/2, height/2, r, r);
}
