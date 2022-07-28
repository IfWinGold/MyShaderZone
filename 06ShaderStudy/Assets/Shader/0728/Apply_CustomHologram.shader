Shader "Custom/Apply_CustomHologram"
{
    Properties
    {                
        _MainTex("MainTexture",2D) = "white"{}
        _BumpMap("NormalMap",2D) = "bump"{}
        _Noise("Noise",2D) = "white"{}
        _Noise02("Noise02",2D) = "white"{}
        _RimCol("HologramColor",Color) = (0,0,0,0)
        _RimPow("HologramPower",Range(0,5)) = 0.5
        _HoloSpeed("HoloSpeed",Range(0,5)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue" = "Transparent"}        
        zwrite on
        ColorMask 0
        //zwrite on render off
        CGPROGRAM                
        #pragma surface surf nolight keepalpha noshadow noambient      
        #pragma target 3.0

        struct Input
        {
           float4 color:COLOR;
        };        
        void surf (Input IN, inout SurfaceOutput o)
        {  
        }
        float4 Lightingnolight(SurfaceOutput s, float3 lightDir, float atten) {

            return float4(0, 0, 0, 0);
        }
        ENDCG

            //zwrite off , rander on


            zwrite off
            CGPROGRAM
#pragma surface surf Lambert vertex:vert alpha:fade
#pragma target 3.0
            sampler2D _MainTex;
        sampler2D _BumpMap;
        sampler2D _Noise;
        sampler2D _Noise02;
        float _RimPow;
        float _HoloSpeed;

        float4 _RimCol;
        

        struct Input {        
            float2 uv_MainTex;
            float2 uv_BumpMap;
            float2 uv_Noise;
            float2 uv_Noise02;
            float3 viewDir;
        };
        void vert(inout appdata_full v) {            
            
            
        }
        void surf(Input IN, inout SurfaceOutput o) {                  
            //Test**
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
            //fixed4 noise = tex2D(_Noise, float2(IN.uv_Noise.x + (_Time.y * _HoloSpeed), IN.uv_Noise.y));
            fixed4 noise = tex2D(_Noise02, float2(IN.uv_Noise02.x, IN.uv_Noise02.y + _Time.y * _HoloSpeed));
            //***
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));

            half3 rim = saturate(dot(o.Normal, IN.viewDir));
            o.Emission = pow(1 - rim, _RimPow) * _RimCol.rgb;                                   

            o.Albedo = c.rgb;
            o.Alpha = noise;//rim * noise;
        }
        ENDCG


    }
    FallBack "Diffuse"
}
