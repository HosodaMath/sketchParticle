precision highp float;
precision highp int;
uniform vec2 resolution;
uniform vec2 mouse;
uniform float time;
const float PI2 = 6.28318530718;
const float TAU = PI2;

vec2 waveEffect(vec2 uv){
  uv.x += 0.0035 * sin(uv.y * 100.0 + time * PI2);
  uv.x += 0.0015 * cos(uv.y * 250.0 + time * PI2);
  
  uv.y += 0.0035 * sin(uv.x * 100.0 + time * PI2);
  uv.y += 0.0015 * cos(uv.x * 250.0 + time * PI2);
  
  return uv;
}

vec2 rotateLoop(vec2 uv, float radian){
  const int iter = 5;
  for(int i = 0; i < iter; i++){
    uv = abs(uv * 1.5) - 1.0;
    float a = radian * float(i);
    float c = cos(a);
    float s = sin(a);
    uv *= mat2(c, s, -s, c);
  }

  return uv;
}

// 乱数生成
float random(vec2 value){
  return fract(sin(dot(value, vec2(12.9898, 78.233))) * 43758.5453);
}

//乱数2
vec2 random2(vec2 value){
  return fract(sin(vec2(dot(value, vec2(127.1, 311.7)), dot(value, vec2(269.5, 183.3)))) * 43758.5453);
}

// ノイズ 多種多様な生成
float valueNoise2(vec2 value){
  vec2 i = floor(value);
  vec2 f = smoothstep(0.0, 1.0, fract(value));
  
  float mix1 = mix(random(i), random(i + vec2(1.0, 0.0)), f.x);
  float mix2 = mix(random(i + vec2(0.0, 1.0)), random(i + vec2(1.0, 1.0)), f.x);
  float valueMix = mix(mix1,mix2,f.y);
  
  return valueMix;
}

// ボロノイ
float voronoi(vec2 uv){
  uv = rotateLoop(uv, time * 0.2);
  vec2 baseCell = floor(uv);
  vec2 fst = fract(uv);
  float move_dist = 10.0;
  for(int x = -1; x <= 1; x++){
    for(int y = -1; y <= 1; y++){
      vec2 cell = vec2(float(x), float(y));
      vec2 point = random2(baseCell + cell);
      point = 0.5 + 0.5 * sin(6.2831 * point);
      vec2 diff = cell + point - fst;
      float cell_dist = length(diff);
      if(cell_dist < move_dist){
        move_dist = cell_dist;
      }
    }
  }

  return move_dist;
}

vec3 createWaterColor(vec2 uv){
  
  vec3 color1 = vec3(0.1, 0.2, 0.6);
  vec3 color2 = vec3(0.2, 0.4, 0.7);
  vec3 bgColor = mix(color1, color2, uv.y);

  float voronoiNoise1 = 0.0;
  float voronoiNoise2 = voronoi(uv);
  float voronoiNoise3 = voronoi(uv);

  vec3 color = vec3(voronoiNoise1, voronoiNoise2, voronoiNoise3);
  color *= 0.9;
  color = pow(color, vec3(4.0));

  vec3 voronoiColor = vec3(color);

  bgColor += voronoiColor;

  return bgColor;
}


void main(){
  vec2 uv = gl_FragCoord.xy / resolution.xy;
  // vec2 uv = (2.0 * gl_FragCoord.xy - resolution) / min(resolution.x, resolution.y);

  uv = waveEffect(uv);

  vec2 uFrequency = vec2(mouse.x * 20.0, mouse.y * 20.0);
  vec2 uAmplitude = vec2(0.05, 0.05);
  float uTime = time;
  float cosWave = cos(uv.y * uFrequency.x + uTime) * uAmplitude.x;
  float sinWave = sin(uv.x * uFrequency.y + uTime) * uAmplitude.y;

  uv.x = uv.x + cosWave;
  uv.y = uv.y + sinWave;

  vec3 bgColor = createWaterColor(uv);

  gl_FragColor = vec4(bgColor, 1.0);
}
