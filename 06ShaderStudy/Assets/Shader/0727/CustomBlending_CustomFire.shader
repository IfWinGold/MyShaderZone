Shader "Custom/CustomBlending_CustomFire"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _NoiseTex("NoisTexture",2D) = "white"{}      
        _FirePower("FirePower",Range(1,5)) = 1
        _FireSpeed("FireSpeed",Range(1,5)) = 1
        _TintColor("TintColor",Color)=(1,1,1,0)
        [Enum(UnityEngine.Rendering.BlendMode)]_SrcBlend("SrcBlend Mode",Float) = 5
        [Enum(UnityEngine.Rendering.BlendMode)]_DstBlend("DstBlend Mode",Float) = 10
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue" = "Transparent"}
        zwrite off
        Blend[_SrcBlend][_DstBlend]


        CGPROGRAM
        #pragma surface surf Lambert keepalpha
        
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _NoiseTex;        
        float4 _TintColor;
        float _FirePower;
        float _FireSpeed;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_NoiseTex;            
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 noise = tex2D(_NoiseTex, float2(IN.uv_NoiseTex.x, IN.uv_NoiseTex.y - (_Time.y * _FireSpeed)));
            float2 uv = saturate(IN.uv_MainTex + (noise.r * _FirePower));
            fixed4 c = tex2D (_MainTex, uv);
            o.Emission = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Legacy Shaders/Transparent/VertexLit"
}
