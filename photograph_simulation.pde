class Wheel {
  PVector posi;
  PVector velo;
  void Wheel(PVector posi_in, PVector velo_in) {
    posi.x = posi_in.x;
    posi.y = posi_in.y;
    velo.x = velo_in.x;
    velo.y = velo_in.y;
  }
  void step() {
    posi.x += velo.x;
    posi.y += velo.y;
  }
}

class Photon {
  Photon(PGraphics lens_field_in) {
    lens_field = lens_field_in;
  }
  float v = 1;
  PGraphics lens_field;
  
  PVector velo = new PVector(random(-v, v), random(-v, v));
  PVector base = new PVector(random(width), random(height));
  PVector left_rotated = v_rotate(velo, PI / 2);
  PVector right_rotate = v_rotate(velo, -PI / 2);
  Wheel left = new Wheel(unit((base + velo).rotate(PI/2)) * dist /2,
                         unit((base + velo).rotate(-PI/2)) * dist /2);
  
  PVector posi = new PVector(random(width), random(height));
  PVector prev_posi = new PVector(posi.x, posi.y);
  PVector velo = new PVector(random(-v, v), random(-v, v));
  color c = color((int)random(255), (int)random(255), (int)random(255), 100);
  ArrayList<PVector> footage = new ArrayList<PVector>();
  float density = 0;
  float prev_density = 0;
  
  void step() {
    posi.x += velo.x;
    posi.y += velo.y;
    density = gray(lens_field.get((int)(posi.x), (int)(posi.y)));
    float diff_density = prev_density - density;
    float shita = map(diff_density, 0, 255, 0, 360);
    v_rotate(shita);
    prev_density = density;
  }
  
  void show() {
    stroke(c);
    line(prev_posi.x, prev_posi.y, posi.x, posi.y);
    prev_posi.x = posi.x;
    prev_posi.y = posi.y;
  }
  
  PVector; v_rotate(PVector velo, float shita) {
    PVector result = new PVector(
    velo.x * cos(shita) + velo.y * sin(shita),
    velo.y * -sin(shita) + velo.y * cos(shita));
    return result;
  }
  
  float gray(color c) {
    return (red(c) + green(c) + blue(c)) / 3.0;
  }
  
}

PGraphics lens_field;
void setup() {
  size(800, 500);
  background(255);
  set_lens_field();
  set_photon();
  image(lens_field, 0, 0);
  println(sketchPath(""));
}

void set_lens_field() {
  lens_field = createGraphics(width, height);
  lens_field.beginDraw();
  lens_field.background(255);
  lens_field.noFill();
  lens_field.strokeWeight(100);
  lens_field.stroke(210, 210, 210);
  lens_field.rect(0, 0, width, height);
  lens_field.endDraw();
}

void set_photon() {
  for (int i = 0; i < 10; i++) {
    Photon p = new Photon(lens_field);
    photons.add(p);
  }
}

ArrayList<Photon> photons = new ArrayList<Photon>();
void draw() {
  for (Photon photon : photons) {
    photon.step();
    photon.show();
  }
}