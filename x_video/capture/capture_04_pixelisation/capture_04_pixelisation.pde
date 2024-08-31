// Example 16-7: Video pixelation
import processing.video.*;
Capture video;

int module;
int[] modules = { 1, 2, 4, 8, 16, 32 };

void setup() {
  size(640, 480);
  stroke(0);  
  video = new Capture(this, width, height);
  video.start();
}

void captureEvent(Capture video) {
  // Read image from the camera
  video.read();
}

void draw() {
  module = 8;
  int index = int(map(mouseX, 0, width, 0, 6));
  module = modules[index];
  
  video.loadPixels();
  
  // Begin loop for columns
  for (int i = 0; i < width; i=i+module) {
    // Begin loop for rows
    for (int j = 0; j < height; j=j+module) {
      color c = video.pixels[i + j * video.width];
      fill(c);
      rect(i, j, module, module);
    }
  }
}
