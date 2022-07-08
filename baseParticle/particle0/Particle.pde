class Particle {
  private PVector position;
  private PVector velocity;
  private float radius;
  public Particle(PVector position, PVector velocity, float radius){
    this.position = position;
    this.velocity = velocity;
    this.radius = radius;
  }

  public void update(){
    this.position.sub(this.velocity);
  }

  public void applyRandom(){
    this.position.x += random(-1.0, 1.0);
  }

  public void draw(){
    fill(250, 250, 100);
    pushMatrix();
    translate(this.position.x, this.position.y, this.position.z);
    circle(0, 0, this.radius);
    popMatrix();
  }

  public void isCheckEdge(){
    float x = random(0, width);
    float y = height + 100;
    if(this.position.y < 0){
      this.position = new PVector(x, y);
    }
  }
}