PVector v = new PVector(0, 0);
PVector m = new PVector(0, 0);
float x, y, xx, yy;
void setup() {
  size(1000, 1000);
  background(255);
  fill(0, 0, 255);
  v = PVector.random2D();
  v.setMag(random(500));
  x = random(width);
  y = random(height);
  xx = random(width);
  yy = random(height);
}

void draw() {
  background(255);
  translate(width/2, height/2);
  stroke(255, 0, 0);
  ellipse(0, 0, 10, 10);
  line(0, 0, v.x, v.y);
  stroke(0, 255, 0);
  ellipse(x, y, 10, 10);
  m.x = mouseX - width / 2;
  m.y = mouseY - height / 2;
  line(0, 0, m.x, m.y);
  text(m.heading() / ( 2 * PI) * 360, 0, 0);
}

void keyPressed() {
  noLoop();
}
