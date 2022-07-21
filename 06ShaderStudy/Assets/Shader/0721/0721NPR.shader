Shader "Custom/0721NPR"
{
    Properties
    {        
        _MainTex ("Albedo (RGB)", 2D) = "white" {}        
        _OutlineWidth("OutLine Width",Range(0.01,0.1)) = 0.01
        _OutlineColor("Outline Color",Color) = (0,0,0,1)

    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }        

        cull front

        //1st Pass
        CGPROGRAM
        
        #pragma surface surf Nolight vertex:vert noshadow noambient
        
        #pragma target 3.0

        sampler2D _MainTex;
        float4 _OutlineColor;
        float _OutlineWidth;
                
        void vert(inout appdata_full v)
        {
            v.vertex.xyz += v.normal.xyz * _OutlineWidth;;
        }
        struct Input
        {
            float4 color:COLOR;
        };
        void surf (Input IN, inout SurfaceOutput o)
        {
        }
        float4 LightingNolight(SurfaceOutput s, float3 lightDir, float atten)
        {
            return _OutlineColor;
        }
        ENDCG




        cull back
        //2st Pass
        CGPROGRAM

        #pragma surface surf Toon noambient

		sampler2D _MainTex;

		struct Input
		{
			float2 uv_MainTex;
		};
		void surf(Input IN, inout SurfaceOutput o)
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
        float4 LightingToon(SurfaceOutput s, float3 lightDir, float atten)
        {
            float ndotl = dot(s.Normal, lightDir) * 0.5 + 0.5;
            
            ndotl = ndotl * 2;
            ndotl = ceil(ndotl) / 5;

            float4 final;
            final.rgb = s.Albedo * ndotl * _LightColor0.rgb;
            final.a = s.Alpha;

            return final;
        }
		ENDCG
    }
    FallBack "Diffuse"
}
