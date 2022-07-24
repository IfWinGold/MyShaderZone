Shader "Custom/CharFace"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Whiteniss("Whiteniss",Range(0,8)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Codereach

        #pragma target 3.0

        sampler2D _MainTex;
        float _Whiteniss;
        int _Ceil;

        struct Input
        {
            float2 uv_MainTex;
        };

        fixed4 _Color;

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb * _Whiteniss;
            o.Alpha = c.a;
        }
        float4 LightingCodereach(SurfaceOutput s, float3 lightDir, float3 viewDir, float atten)
        {
            float4 final;
            float ndotl = saturate(dot(s.Normal, lightDir));
            final.rgb = ndotl * s.Albedo * _LightColor0.rgb * atten;
            final.a = s.Alpha;
            return final;
        }
            
        ENDCG
    }
    FallBack "Diffuse"
}
