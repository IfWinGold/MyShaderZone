Shader "Custom/0720CustomHologram"
{
    Properties
    {        
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _RimColor("RimColor",Color) = (1,1,1,1)
        _RimPower("RimPower",Range(0,5)) = 3
        _BumpMap("BumpMap",2D) = "white"{}
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" "Queue" = "Transparent" }
 

        CGPROGRAM
        #pragma surface surf Lambert noambient alpha:fade

        sampler2D _MainTex;    
    sampler2D _BumpMap;
        float4 _RimColor;
        float _RimPower;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_BumpMap;
            float3 viewDir;
        };        

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex);            
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));

            float3 rim = dot(o.Normal,IN.viewDir);            
            rim = pow(1 - rim, _RimPower);
            o.Alpha = rim;

            o.Emission = _RimColor;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
