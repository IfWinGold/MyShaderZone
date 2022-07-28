Shader "Custom/DrawAlpha"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _DestTex("Destination",2D) = "white"{}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue" = "Transparent"}
        zwrite off

        CGPROGRAM        
        #pragma surface surf Lambert keepalpha
        
        #pragma target 3.0

        sampler2D _MainTex;
    sampler2D _DestTex;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_DestTex;
        };                

        void surf (Input IN, inout SurfaceOutput o)
        {            
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 d = tex2D(_DestTex, IN.uv_DestTex);
            float3 temp = c.rgb * d.rgb;
            float3 tempx = temp.rgb + temp.rgb;
            o.Emission = tempx;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
