@group(0) @binding(1) var mySampler: sampler;
@group(0) @binding(2) var myTexture: texture_cube<f32>;

@fragment
fn main(
  @location(0) fragUV: vec2f,
  @location(1) fragPosition: vec4f
) -> @location(0) vec4f {
  // Our camera and the skybox cube are both centered at (0, 0, 0)
  // so we can use the cube geometry position to get viewing vector to sample
  // the cube texture. The magnitude of the vector doesn't matter.
  var cubemapVec = fragPosition.xyz - vec3(0.5);
  // When viewed from the inside, cubemaps are left-handed (z away from viewer),
  // but common camera matrix convention results in a right-handed world space
  // (z toward viewer), so we have to flip it.
  let p = normalize(cubemapVec);
  //cubemapVec.z *= -1; // <----- not needed if we flip the world space
  var ret = textureSample(myTexture, mySampler, cubemapVec);

  // Solid = positive direction; ring = negative direction
  if abs(p.x) > 0.75 && p.x > -0.76 { ret.r += 0.5; }
  if abs(p.y) > 0.75 && p.y > -0.76 { ret.g += 0.5; }
  if abs(p.z) > 0.75 && p.z > -0.76 { ret.b += 0.5; }
  return ret;
}
