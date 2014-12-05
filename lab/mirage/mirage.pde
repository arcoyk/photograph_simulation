class Photon {
  PVector posi = new PVector(random(width), random(height));
  PVector velo = PVector.random2D();
  color c = color(255, 0, 0);
  Photon(float x, float y, float vx, float vy) {
    posi.x = x;
    posi.y = y;
    velo.x = vx;
    velo.y = vy;
  }
  void step() {
    float prev_dens = gray(field.get((int)posi.x, (int)posi.y));
    posi.add(velo);
    float dens = gray(field.get((int)posi.x, (int)posi.y));
    velo.rotate(map(prev_dens - dens, -255, 255, -10, 10));
  }
  void show() {
    step();
    stroke(c);
    point(posi.x, posi.y);
  }
}

PGraphics field;
Photon p;
void setup() {
  size(800, 800);
  field = createGraphics(width, height);
  field.beginDraw();
  field.background(255);
  field.endDraw();
  gradField();
  // rectField();
  p = new Photon(0, height / 2, 1, 0);
  image(field, 0, 0);
}

void draw() {
  p.show();
}

void gradField() {
  field.beginDraw();
  for (int x = 0; x < field.width; x++) {
    field.stroke(map(x, 0, field.width, 255, 0));
    field.line(x, 0, x, field.height);
  }
  field.endDraw();
}

float gray(color c) {
  return (red(c) + green(c) + blue(c)) / 3.0;
}

void rectField() {
  field.beginDraw();
  field.noStroke();
  field.fill(100);
  field.rect(field.width / 2, 0, field.width, field.height);
  field.endDraw();
}
