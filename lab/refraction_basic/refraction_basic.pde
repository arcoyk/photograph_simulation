PVector surface_normal = new PVector(0, -1);
float K = 1.9;
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
    } else if (posi.y < height / 2 && prev.y > height / 2) {
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
    int angle_class = 0;
    float h = velo.heading();
    if ( h < 0 ) {
      h = 2 * PI + h;
    }
    if ( 0 <= h && h < PI / 2) {
      angle_class = 0;
    } else if ( PI / 2 <= h && h < PI) {
      angle_class = 1;
    } else if ( PI <= h && h < PI * (float)3 / 2) {
      angle_class = 2;
    } else if ( PI * (float)3 / 2 <= h && h < 2 * PI) {
      angle_class = 3;
    }
    float in_theta = 0;
    
    if (angle_class == 0 || angle_class == 1) {
      in_theta = PI - PVector.angleBetween(surface_normal, velo);
    } else {
      in_theta = PVector.angleBetween(surface_normal, velo);
    }
    
    float out_theta = asin(sin(in_theta) / K);    
    float diff_theta = in_theta - out_theta;
    if (angle_class == 0 || angle_class == 3) {
      velo.rotate(diff_theta);
    } else {
      velo.rotate(-diff_theta);
    }
  }
}

ArrayList<Photon> photons = new ArrayList<Photon>();
void init_photons() {
  int amount = 1;
  PVector center = new PVector(width / 2, height /2);
  float radius = 200;
  for (int i = 0; i < amount; i++) {
    float theta = 2 * PI / amount * i;
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
  fill(255, 255, 255, 50);
  rect(0, 0, width, height);
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
  for (Photon ps : photons) {
    if ( PVector.dist(new PVector(width / 2, height / 2), ps.posi) > 500) {
      ps.posi.x = ps.org_posi.x;
      ps.posi.y = ps.org_posi.y;
      ps.prev.x = ps.posi.x;
      ps.prev.y = ps.posi.y;
      ps.velo.x = ps.org_velo.x;
      ps.velo.y = ps.org_velo.y;
      ps.go_flag = false;
    }
  }
}

int cnt = 0;
void keyPressed() {
  if (key == 'c') {
    background(255);
  }else if (key == 'k') {
    K += 0.5;
  }else if (key == 'j') {
    K -= 0.5;
  }else {
  }
  println(K);
}

void mouseMoved() {
  // surface_normal.x = mouseX - width / 2;
  // surface_normal.y = mouseY - height / 2;
}

void mouseClicked() {
  for (Photon ps : photons) {
    ps.posi.x = mouseX;
    ps.posi.y = mouseY;
    ps.prev.x = ps.posi.x;
    ps.prev.y = ps.posi.y;
    ps.velo.x = width / 2 - mouseX;
    ps.velo.y = height / 2 - mouseY;
    ps.velo.setMag(10);
    ps.go_flag = true;
  }
  
}


