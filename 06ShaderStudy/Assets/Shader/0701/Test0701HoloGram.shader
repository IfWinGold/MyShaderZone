Shader "Custom/Test0701HoloGram"
{
    Properties
    {
        _BumpMap("NormalMap",2D) = "bump"{}        
        _RimColor("RimColor",Color) = (1,1,1,1)
        _RimPower("RimPower",Range(0,10)) = 3
        _FlashSpeed("FlashSpeed",Range(0,20)) = 5
        _Height("Height",Range(1,50)) = 30
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue" = "Transparent"}

        CGPROGRAM
        #pragma surface surf nolight noambient alpha:fade

        
        sampler2D _BumpMap;
        fixed4 _RimColor;
        float _RimPower;
        float _FlashSpeed;
        float _Height;

        struct Input
        {            
            float2 uv_BumpMap;
            float3 viewDir;
            float3 worldPos;
        };


        void surf (Input IN, inout SurfaceOutput o)
        {            
            o.Normal = UnpackNormal(tex2D(_BumpMap,IN.uv_BumpMap));
            o.Emission = _RimColor;
            float rim = saturate(dot(o.Normal, IN.viewDir));         
            rim = pow(1 - rim,_RimPower) + pow(frac(IN.worldPos.g * 3 - _Time.y), _Height);;
            //Flash 없음
            //o.Alpha = rim;
            //Flash 있음
            o.Alpha = rim*saturate(sin(_Time.y)*_FlashSpeed * 10);
        }

        float4 Lightingnolight(SurfaceOutput s, float3 lightDir, float atten) {
            return float4(0, 0, 0, s.Alpha);
        }

        ENDCG
    }
    FallBack "Diffuse"
}
