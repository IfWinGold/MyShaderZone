Shader "Custom/CustomBlending_One_One"
{
    Properties
    {        
        _MainTex ("Albedo (RGB)", 2D) = "white" {}        
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue" = "Transparent"}        
        zwrite off
        blend One One

        CGPROGRAM        
        #pragma surface surf Lambert keepalpha        
        #pragma target 3.0

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {            
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            o.Emission = c.rgb;                        
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
