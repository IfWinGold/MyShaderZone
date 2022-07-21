Shader "Custom/Test0629_uv"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _FlowSpeed("flowSpeed",Range(0,2)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard 


        sampler2D _MainTex;
        float _FlowSpeed;

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {            
            fixed4 c = tex2D (_MainTex,float2(IN.uv_MainTex.x + _Time.y*_FlowSpeed, IN.uv_MainTex.y));
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
