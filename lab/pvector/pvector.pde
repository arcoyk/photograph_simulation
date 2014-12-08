PVector v = new PVector(0, 0);
PVector m = new PVector(100, 100);
PVector c = new PVector(0, 0);

void setup() {
  size(500, 500);
  c.x = width / 2;
  c.y = height / 2;
}

void draw() {
  background(255);
  proc();
  show_params();
  stroke(0, 255, 0);
  vector_line(v);
  stroke(255, 0, 0);
  vector_line(m);
}

void proc() {
  v.x = mouseX - c.x;
  v.y = mouseY - c.y;
  m.rotate(PI / 40);
}

void show_params() {
  fill(0);
  int offset = 50;
  int i = 1;
  text("angleBetween " + PVector.angleBetween(v, m), 20, offset * i++);
  text("v mag " + v.mag(), 20, offset * i++);
  text("m heaing " + m.heading(), 20, offset * i++);
}

void vector_line(PVector v) {
  line(c.x, c.y, c.x + v.x, c.y + v.y);
}
