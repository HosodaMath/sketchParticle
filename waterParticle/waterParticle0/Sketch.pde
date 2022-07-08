class Sketch {
  ParticleSystem particleSystem;
  PGraphics canvas;
  PShader filterShader;
  public Sketch(){
    this.canvas = createGraphics(width, height, P3D);
    this.particleSystem = new ParticleSystem(this.canvas);

    filterShader = loadShader(
      "./shader/filter/water/water0.frag", 
      "./shader/filter/water/water0.vert"
    );
  }

  public void start(){
    this.canvas.beginDraw();
  }

  public void set(){
    this.canvas.noStroke();
    this.canvas.background(0, 0, 0);
  }

  public void particle(){
    particleSystem.update();
    particleSystem.draw();
    particleSystem.isCheckEdge();
  }

  public void end(){
    this.canvas.endDraw();
  }

  public void sketch(){
    PVector uFrequency = new PVector(
      map(mouseX, 0, width, -20.0, 20.0), 
      map(mouseY, 0, height, -20.0, 20.0)
    );

    PVector uAmplitude = new PVector(
      map(mouseX, 0, width, -0.05, 0.05), 
      map(mouseY, 0, height, -0.05, 0.05)
    );

    float uFrameCount = frameCount;
    float uTime = uFrameCount * 0.005;
    shader(this.filterShader);
    this.filterShader.set("uFrequency", uFrequency.x, uFrequency.y);
    this.filterShader.set("uAmplitude", uAmplitude.x, uAmplitude.y);
    this.filterShader.set("uTime", uTime);
    this.filterShader.set("uTexture", this.canvas);
    pushMatrix();
    translate(0, 0, 0);
    rect(0, 0, width, height);
    popMatrix();
    resetShader();
  }
}