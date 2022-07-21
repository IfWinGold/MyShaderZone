Shader "Custom/0721Wrap"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _RampTex("RampTex",2D) = "white"{}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }        

        CGPROGRAM

        #pragma surface surf warp noambient
        
        #pragma target 3.0

        sampler2D _MainTex;
    sampler2D _RampTex;

        struct Input
        {
            float2 uv_MainTex;            
        };

        void surf (Input IN, inout SurfaceOutput o)
        {            
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;                        
            o.Alpha = c.a;
        }
        float4 Lightingwarp(SurfaceOutput s, float3 lightDir, float atten)
        {
            float ndotl = dot(s.Normal, lightDir);
            return ndotl;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
