class ParticleSystem {
  ArrayList<Particle> particle;
  public ParticleSystem(PGraphics canvas){
    this.particle = init(canvas, 100);
  }

  ArrayList<Particle> init(PGraphics canvas,  int particleMax){
    ArrayList<Particle> particle = new ArrayList<Particle>();

    float shiftY = 100;
    for(int count = 0; count < particleMax; count++){
      float positionX = random(0, width);
      float positionY = random(0 + shiftY, height);
      float positionZ = 0;
      PVector position = new PVector(positionX, positionY, positionZ);

      float velocityX = 0;
      float velocityY = random(1, 2);
      float velocityZ = 0;
      PVector velocity = new PVector(velocityX, velocityY, velocityZ);

      float radius = random(10, 50);

      particle.add(new Particle(canvas, position,velocity, radius));
    }

    return particle;
  }

  public void update(){
    for(int count = 0; count < this.particle.size(); count++){
      this.particle.get(count).update();
      this.particle.get(count).applyRandom();
    }
  }

  public void draw(){
    for(int count = 0; count < this.particle.size(); count++){
      this.particle.get(count).draw();
    }
  }

  public void isCheckEdge(){
    for(int count = 0; count < this.particle.size(); count++){
      this.particle.get(count).isCheckEdge();
    }
  }
}