class Spiner {
  Spiner() {
  }
  PVector center = new PVector(0, 0);
  float shita = 0;
  float phai = shita + PI;
  PVector left = new PVector(0, 0);
  PVector right = new PVector(0, 0);
  float R = 100;
  float DIV = 1000;
  void show() {
    update();
    ellipse(center.x, center.y, R / 2, R / 2);
    ellipse(left.x, left.y, 10, 10);
    ellipse(right.x, right.y, 10, 10);
  }
  void update() {
    float dist = PI - (phai - shita);
    if (dist > PI / 100) {
      shita += dist / DIV;
      phai += dist / DIV;
    }
    left.x = center.x + R * cos(shita);
    left.y = center.y + R * sin(shita);
    right.x = center.x + R * cos(phai);
    right.y = center.y + R * sin(phai);
  }
}

void setup() {
  size(500, 500);
}

Spiner spin = new Spiner();
void draw() {
  background(255);
  spin.center.x = mouseX;
  spin.center.y = mouseY;
  spin.show();
}

void mousePressed() {
  spin.phai = random(PI);
}
