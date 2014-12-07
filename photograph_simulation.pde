void setup() {
  size(500, 500);
}

PVector v = new PVector(random(-100), random(-100));
void draw() {
  translate(width / 2, height / 2);
  background(255);
  stroke(255, 0, 0);
  line(0, 0, v.x, v.y);
  stroke(100);
  v.rotate(PI/2);
  line(0, 0, v.x * 10, v.y * 10);
  v.rotate(-PI);
  line(0, 0, v.x * 10, v.y * 10);
  v.rotate(PI/2);
}
