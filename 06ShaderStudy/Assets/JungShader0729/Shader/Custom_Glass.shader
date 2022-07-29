Shader "Custom/Custom_Glass"
{
    //내부는 안비치게

    Properties
    {        
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _GlossTex("Gloss Tex",2D) = "white"{}
        _BumpMap("NormalMap",2D) = "bump"{}
        _Cube("CubeMap",Cube) = ""{}      
        _SpecPow("SpecPower",Range(10,200)) = 10
        _SpecCol("SpecColor",Color) = (1,1,1,1)
        _GlossPow("GlossPower",Range(0,5)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM        
        #pragma surface surf GlassLight
        
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _GlossTex;
        sampler2D _BumpMap;

        samplerCUBE _Cube;
        float _Smooth;
        float _SpecPow;
        float _GlossPow;
        float4 _SpecCol;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_BumpMap;
            float2 uv_GlossTex;
            float3 worldRefl;     

            INTERNAL_DATA
        };        
        void surf (Input IN, inout SurfaceOutput o)
        {            
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
            fixed4 m = tex2D(_GlossTex, IN.uv_GlossTex);
            float4 re = texCUBE(_Cube, WorldReflectionVector(IN, o.Normal));

            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));            
            o.Albedo = c.rgb * 0.5;
            o.Emission = re.rgb * 0.5;      
            o.Gloss = m.a * _GlossPow;
            o.Alpha = c.a;
        }
        float4 LightingGlassLight(SurfaceOutput s, float3 lightDir, float3 viewDir, float atten)
        {
            float4 final;
            //Lambert term
            float3 DiffColor;
            float ndotl = saturate(dot(s.Normal, lightDir));
            DiffColor = ndotl * s.Albedo * _LightColor0.rgb * atten;
            final.rgb = DiffColor.rgb;

            //Spec term
            float3 SpecColor;
            float3 H = normalize(lightDir + viewDir);
            float spec = saturate(dot(H, s.Normal));
            spec = pow(spec, _SpecPow);
            SpecColor = spec * _SpecCol.rgb * s.Gloss;

            //final term
            final.rgb = DiffColor.rgb + SpecColor.rgb;
            final.a = s.Alpha;
            return final;            
        }
        ENDCG
    }
    FallBack "Diffuse"
}
