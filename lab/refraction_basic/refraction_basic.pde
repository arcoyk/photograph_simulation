PVector surface_normal = new PVector(0, -1);
class Photon {
  boolean go_flag = false;
  PVector posi = new PVector(0, 0);
  PVector velo = new PVector(0, 0);
  color c = color((int)random(255),
                  (int)random(255),
                  (int)random(255));
  PVector prev = new PVector(0, 0);
  Photon(float x, float y) {
    posi.x = x;
    posi.y = y;
    prev.x = posi.x;
    prev.y = posi.y;
  }
  void step() {
    if (!go_flag) {
      return;
    }
    posi.x += velo.x;
    posi.y += velo.y;
    if (posi.y > height / 2) {
      refrection(surface_normal);
    }
    show();
  }
  void show() {
    stroke(c);
    line(prev.x, prev.y, posi.x, posi.y);
    prev.x = posi.x;
    prev.y = posi.y;
  }
  void refrection(PVector surface_normal) {
  }
}

ArrayList<Photon> photons = new ArrayList<Photon>();
void init_photons() {
  int amount = 10;
  PVector center = new PVector(width / 2, height /2);
  float radius = 200;
  for (int i = 0; i < amount; i++) {
    float theta = PI / amount * i;
    Photon p = new Photon(center.x + radius * cos(theta),
                          center.y - radius * sin(theta));
    p.velo.x = -cos(theta);
    p.velo.y = sin(theta);
    p.velo.setMag(1);
    photons.add(p);
  }
}

void setup() {
  size(500, 500);
  background(255);
  init_photons();
}

void draw() {
  for (Photon p : photons) {
    p.step();
  }
  PVector surface = new PVector(surface_normal.x, surface_normal.y);
  surface.rotate(PI / 2);
  stroke(0);
  line(width / 2 + surface.x * width,
       height / 2 + surface.y * height,
       width / 2 + surface.x * -width,
       height / 2 + surface.y * -height);
  stroke(255, 0, 0);
  line(width / 2,
       height / 2,
       width / 2 + surface_normal.x * 10,
       height / 2 + surface_normal.y * 10);
}

int cnt = 0;
void keyPressed() {
  println(photons.size());
  Photon p = photons.get(cnt++ % photons.size());
  p.go_flag = !p.go_flag;
}
