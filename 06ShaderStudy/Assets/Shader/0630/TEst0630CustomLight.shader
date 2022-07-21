Shader "Custom/Test0630CustomLight"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _BumpMap("NormalMap",2D) = "bump"{}
        _Atten("Atten",Range(0,2)) = 1

        _SpecColor("Specular Color",color) = (1,1,1,1)
        _Gloss("Gloss",Range(0,1)) = 0.5
     
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        CGPROGRAM

        #pragma surface surf Test


        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _BumpMap;
        float _Atten;
        float _Gloss;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_BumpMap;
        };



        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);            
            o.Albedo = c.rgb;
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));         

            o.Specular = 1;
            o.Gloss = _Gloss;
            o.Alpha = c.a;
        }

        float4 LightingTest(SurfaceOutput s, float3 lightDir, float atten)
        {
            //float ndotl = saturate(dot(s.Normal,lightDir));
            float ndotl = dot(s.Normal, lightDir)*0.5+0.5;  //Half-Lambert = *0.5 + 0.5;                       
            float4 final;
            final.rgb = ndotl * s.Albedo * _LightColor0.rgb * (atten*_Atten);
            final.a = s.Alpha;
            return final;
        }

        ENDCG
    }
    FallBack "Diffuse"
}
