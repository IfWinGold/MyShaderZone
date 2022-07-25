Shader "Custom/0725AlphaBlend"
{
    Properties
    {              
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue" = "Transparent"}
        //Queue -> '그리는 순서'를 의미 Transparent라고 하면 '불투명 다음'에 그리는 것을 의미


        //양면 렌더
        cull off
       
        CGPROGRAM       
        #pragma surface surf Lambert alpha:fade    
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
    //그림자가 Quad 모양으로 생성되는것을 사라지게 함
    FallBack "Legacy Shaders/Transparent/VertexLit"
}
