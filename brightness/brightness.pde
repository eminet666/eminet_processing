// https://processing.org/reference/brightness_.html
// Extracts the brightness value from a color. 

noStroke();
// HSB
// colorMode(HSB, 255);
// color c = color(0, 126, 255);

// RGB
colorMode(RGB, 255, 255, 255);
color c = color(255, 129, 129);

fill(c);
rect(15, 20, 35, 60);
float value = brightness(c);  // Sets 'value' to 255
fill(value);
rect(50, 20, 35, 60);
