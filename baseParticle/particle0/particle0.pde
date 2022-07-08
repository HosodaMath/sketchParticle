Particle particle;
void setup() {
  size(1024, 1024, P3D);
  noStroke();

  PVector position = new PVector(width * 0.5, height * 0.5, 0.0);
  PVector velocity = new PVector(0, 1, 0);
  float radius = 50;
  particle = new Particle(position, velocity, radius);
}

void draw() {
  background(0, 0, 0);

  particle.update();
  particle.applyRandom();
  particle.draw();
  particle.isCheckEdge();
}
