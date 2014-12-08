PVector surface_normal = new PVector(0, -1);
float K = 1.5;
class Photon {
  boolean go_flag = false;
  PVector posi = new PVector(0, 0);
  PVector velo = new PVector(0, 0);
  color c = color((int)random(255),
                  (int)random(255),
                  (int)random(255));
  PVector prev = new PVector(0, 0);
  PVector org_posi = new PVector(0, 0);
  PVector org_velo = new PVector(0, 0);
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
    if (prev.y < height / 2 && posi.y > height / 2) {
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
    float in_theta = PI - PVector.angleBetween(surface_normal, velo);
    float out_theta = asin(sin(in_theta) / K); //sin(in_theta) / sin(out_theta) = K
    println("IN:" + map(in_theta, 0, PI, 0, 180));
    println("OUT:" + map(out_theta, 0, PI, 0, 180));
    if (in_theta < out_theta) {
      out_theta = PI - out_theta;
    }
    if (abs(velo.heading()) < PI / 2) {
      velo.rotate(in_theta - out_theta);
    }else {
      velo.rotate(out_theta - in_theta);
    }
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
    p.velo.setMag(5);
    // keep original params
    p.org_posi.x = p.posi.x;
    p.org_posi.y = p.posi.y;
    p.org_velo.x = p.velo.x;
    p.org_velo.y = p.velo.y;
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
  Photon p = photons.get(cnt++ % photons.size());
  if (key == 'c') {
    background(255);
    for (Photon ps : photons) {
      ps.posi.x = ps.org_posi.x;
      ps.posi.y = ps.org_posi.y;
      ps.velo.x = ps.org_velo.x;
      ps.velo.y = ps.org_velo.y;
    }
  }else if (key == 'k') {
    K += 0.5;
  }else if (key == 'j') {
    K -= 0.5;
  }else {
    p.go_flag = !p.go_flag;
  }
  println(K);
}

void mouseMoved() {
}
