Shader "Custom/AlphaTesting"
{
    Properties
    {
        //_Color 구문을 살려놓은 이유는 없을경우 그림자가 나오지 않기때문
        //즉, 그림자를 그리는 Pass에서 그림자 색상을 위해서 해당 인자를 사용.
        _Color ("Color", Color) = (1,1,1,1) //추가        

        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Cutoff("Alpha cutoff",Range(0,1)) = 0.5 //추가
    }
    SubShader
    {
        Tags { "RenderType"="Transparentcutout" "Queue" = "AlphaTest"} //추가
        LOD 200

        CGPROGRAM       
        #pragma surface surf Lambert alphatest:_Cutoff //추가

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
    FallBack "Legacy Shaders/Transparent/Cutout/VertexLit"
    //Cutout 계열의 쉐이더 이름을 써주어야 그림자가 제대로 나옴.

}
