Shader "Custom/CustomBlending_DstColor_Zero"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}        
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue" = "Transparent"}        
        zwrite off
        blend DstColor Zero


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
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Legacy Shader/Transparent/VertexLit"
}
