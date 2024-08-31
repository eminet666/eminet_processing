// à verifier _ après 10'
// https://www.youtube.com/watch?v=nCVZHROb_dE&list=PLRqwX-V7Uu6aG2RJHErXKSWFDXU4qo_ro&index=2
import processing.video.*;

Capture video;
color trackColor = color(255, 150, 60); 
float threshold = 25;

void setup() {
  size(640, 480);
  video = new Capture(this, width, height);
  video.start();  
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
  video.loadPixels();
  image(video, 0, 0);

  // Before we begin searching, the "world record" for closest color is set to a high number that is easy for the first pixel to beat.
  float worldRecord = 500; 

  // XY coordinate of closest color
  float avgX = 0;
  float avgY = 0;
  int count = 0;

  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      int loc = x + y*video.width;
      // What is current color
      color currentColor = video.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      float r2 = red(trackColor);
      float g2 = green(trackColor);
      float b2 = blue(trackColor);

      // Using euclidean distance to compare colors
      float d = dist(r1, g1, b1, r2, g2, b2);

      // If current color is more similar to tracked color
      if (d < threshold) {
        avgX += x;
        avgY += y;
        count++;
      }
    }
  }

  // We only consider the color found if its color distance is less than 10. 
  if (count < 10) { 
    avgX = avgX / count;
    avgY = avgY / count;
    // Draw a circle at the tracked pixel
    fill(trackColor);
    strokeWeight(4.0);
    stroke(0);
    ellipse(avgX, avgY, 16, 16);
  }
}
