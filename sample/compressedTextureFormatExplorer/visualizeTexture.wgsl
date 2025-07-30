@group(0) @binding(0) var mySampler : sampler;
@group(0) @binding(1) var myTexture : texture_2d<f32>;

struct VertexOutput {
  @builtin(position) Position : vec4f,
  @location(0) fragUV : vec2f,
}

@vertex
fn vert_main(@builtin(vertex_index) VertexIndex : u32) -> VertexOutput {
  const pos = array(
    vec2( 0.9,  0.9),
    vec2( 0.9, -0.9),
    vec2(-0.9, -0.9),
    vec2( 0.9,  0.9),
    vec2(-0.9, -0.9),
    vec2(-0.9,  0.9),
  );

  const uv = array(
    vec2(1.0, 0.0),
    vec2(1.0, 1.0),
    vec2(0.0, 1.0),
    vec2(1.0, 0.0),
    vec2(0.0, 1.0),
    vec2(0.0, 0.0),
  );

  var output : VertexOutput;
  output.Position = vec4(pos[VertexIndex], 0.0, 1.0);
  output.fragUV = uv[VertexIndex];
  return output;
}

@fragment
fn frag_main(@location(0) fragUV : vec2f) -> @location(0) vec4f {
  // First generate a checkerboard background
  let checkerboardXY = vec2u(fragUV * 60);
  let background = f32((checkerboardXY.x + checkerboardXY.y) % 2) * 0.3 + 0.2;
  
  // Then sample the textuer and blend it into the background
  let color = textureSample(myTexture, mySampler, fragUV);
  return vec4(color.rgb * color.a + background * (1 - color.a), 1);
}
