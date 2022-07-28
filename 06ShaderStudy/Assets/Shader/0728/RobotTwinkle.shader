Shader "Custom/RobotTwinkle"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MaskTex("Mask(Green)",2D) = "white"{}
        _RampTex("Ramp",2D) = "white"{}
        _Blooom("BloomPower",Range(1,5)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }        

        CGPROGRAM        
        #pragma surface surf Lambert 
        
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _MaskTex;
        sampler2D _RampTex;
        float _Blooom;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MaskTex;
            float2 uv_RampTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {            
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 d = tex2D(_MaskTex, IN.uv_MaskTex);
            float4 Ramp = tex2D(_RampTex, float2(_Time.y, 0.5));
            o.Albedo = c.rgb;
            o.Emission = c.rgb * (d.g* _Blooom) * Ramp.r;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
