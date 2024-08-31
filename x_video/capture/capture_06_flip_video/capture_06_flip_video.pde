import processing.video.*;

Capture cam;

void setup() {
  size(640, 480);
  cam = new Capture(this, 640, 480);
  cam.start();
}

void captureEvent(Capture cam) {
  cam.read();
}

void draw() {
  pushMatrix();   // just so nothing else is affected
  scale(-1, 1);
  image(cam, -cam.width, 0);
  popMatrix();
}
