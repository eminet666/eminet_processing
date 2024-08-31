// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com
// Example 16-1: Display video

// Step 1. Import the video library
import processing.video.*;

// Step 2. Declare a Capture object
Capture video;

void setup() {
  size(640, 480);
  String[] cameras = Capture.list();
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println("camera "+i+" : "+ cameras[i]);
    }
  }
  // Step 3. Initialize Capture object via Constructor
  // Use the default camera at 320x240 resolution
  video = new Capture(this, 640, 480);
  video.start();
}

// An event for when a new frame is available
void captureEvent(Capture video) {
     // Step 4. Read the image from the camera.
     video.read();
}

void draw() {
  // Step 5. Display the video image.
  image(video, 0, 0);
}
