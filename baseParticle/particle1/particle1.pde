ParticleSystem particleSystem;
void setup() {
  size(1024, 1024, P3D);
  noStroke();

  particleSystem = new ParticleSystem();
}

void draw() {
  background(0, 0, 0);

  particleSystem.update();
  particleSystem.draw();
  particleSystem.isCheckEdge();

}
