Shader "Custom/0725AlphaBlend"
{
    Properties
    {              
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue" = "Transparent"}
        //Queue -> '�׸��� ����'�� �ǹ� Transparent��� �ϸ� '������ ����'�� �׸��� ���� �ǹ�


        //��� ����
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
    //�׸��ڰ� Quad ������� �����Ǵ°��� ������� ��
    FallBack "Legacy Shaders/Transparent/VertexLit"
}
