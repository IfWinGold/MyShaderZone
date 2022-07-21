Shader "Custom/Test0629_Fire2"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _MainTex2("Albedo (RGB)" ,2D) = "white"{}
        _Power("Power",Range(0,1)) = 1
        _FireOpaque("FireOpaque",Range(0,1)) = 1
    }
        SubShader
    {
        Tags { "RenderType" = "Transparent" "Queue" = "Transparent"}

        CGPROGRAM
        #pragma surface surf Standard alpha:fade


        sampler2D _MainTex;
        sampler2D _MainTex2;
        float _Power;
        float _FireOpaque;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_MainTex2;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {            
            fixed4 d = tex2D(_MainTex2,float2(IN.uv_MainTex2.x,IN.uv_MainTex2.y - _Time.y));
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex + d.r*_Power);            
            o.Emission = c.rgb;
            o.Alpha = c.a*_FireOpaque;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
