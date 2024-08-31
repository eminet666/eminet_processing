import processing.video.*;
Capture video;

int threshold = 127; // Set the threshold value

color black = color(0);
color white = color(255);
int numPixels;


void setup() {
  size(640, 480); // Change size to 320 x 240 if too slow at 640 x 480
  
  // This the default video input, see the GettingStartedCapture 
  video = new Capture(this, width, height, 15);
  video.start(); 
  
  numPixels = video.width * video.height;
  smooth();
}

void draw() {
  if (video.available()) {
    video.read();
    
    // Turn each pixel in the video frame black or white depending on its brightness
    loadPixels();
    for (int i = 0; i < numPixels; i++) {
      float  pixelBrightness = brightness(video.pixels[i]);
      if (pixelBrightness > threshold) { // If the pixel is brighter than the
        pixels[i] = white; // threshold value, make it white
      } 
      else { // Otherwise,
        pixels[i] = black; // make it black
      }
    }
    updatePixels();
  }
}
