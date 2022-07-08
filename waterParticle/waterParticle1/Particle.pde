class Particle {
  PGraphics canvas;
  private PVector position;
  private PVector velocity;
  private float radius;
  public Particle(PGraphics canvas, PVector position, PVector velocity, float radius){
    this.canvas = canvas;
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

  public void draw(int count){
      // this.canvas.fill(0, 0, 30);
      // this.canvas.pushMatrix();
      // this.canvas.translate(this.position.x, this.position.y, this.position.z);
      // this.canvas.circle(0, 0, this.radius);
      // this.canvas.popMatrix();
    float alpha = 200;
    if(count % 2 == 0){
      this.canvas.noStroke();
      this.canvas.fill(0, 0, 50, alpha);
      this.canvas.pushMatrix();
      this.canvas.translate(this.position.x, this.position.y, this.position.z);
      this.canvas.circle(0, 0, this.radius);
      this.canvas.popMatrix();
    } else {
      this.canvas.noFill();
      this.canvas.stroke(0, 0, 30, alpha);
      this.canvas.strokeWeight(10);
      this.canvas.pushMatrix();
      this.canvas.translate(this.position.x, this.position.y, this.position.z);
      this.canvas.circle(0, 0, this.radius);
      this.canvas.popMatrix();
    }
  }

  public void isCheckEdge(){
    float x = random(0, width);
    float y = height + 100;
    if(this.position.y < 0){
      this.position = new PVector(x, y);
    }
  }
}