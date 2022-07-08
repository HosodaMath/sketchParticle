Sketch sketch;
/**
  今回の改良点
  Processing
  fillのみをfillとstroke交互に出すように改良
  GLSL(Filterなので減算合成)
  voronoi側にグラデーションをかける
  今後の課題
  Processing
  穴あきポリゴンを用意する
  GLSL
  Particleにもシェーダーをかけられるようにする
*/
void setup() {
  size(1024, 1024, P3D);
  noStroke();

  sketch = new Sketch();
  
}

void draw() {
  background(0, 0, 0);

  sketch.start();
  sketch.set();
  sketch.particle();
  sketch.end();
  sketch.sketch();

  // saveFrame("./frames/########.png");
}
