void POM_float(Texture2D heightTex, float2 UV, SamplerState heightSampler, int heightChannel, float heightScale, float heightOffset, int minSteps, int maxSteps, float3 viewDir, out float2 offsetUV)
{
  float steps = clamp(lerp(maxSteps, minSteps, abs(dot(float3(0, 0, 1), viewDir))), 30, 200);
  float height = 1.0;
  float step = 1.0 / steps;
  
  offsetUV = UV;
  float heightMap = heightTex.Sample(heightSampler, offsetUV)[heightChannel] + heightOffset;
  
  float2 uvDelta = viewDir.xy * (step * heightScale);

  for (float i = 0.0f; i < steps && heightMap < height; i++)
  {
      height -= step;
      offsetUV -= uvDelta;
      heightMap = heightTex.Sample(heightSampler, offsetUV)[heightChannel] + heightOffset;
  }
}