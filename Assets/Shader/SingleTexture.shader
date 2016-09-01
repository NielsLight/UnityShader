Shader "MyUnityShader/SingleTexture"
{
	Properties
	{
		
		_MainTex("Main Texture",2D) = "white" {}
	}
		SubShader
	{
		Pass
		{
			CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				uniform sampler2D _MainTex;
				uniform float4 _MainTex_ST;
				struct vertexInput
				{
					float4 vertex:POSITION;
					float4 tex:TEXCOORD0;
				};
				struct vertexOutput
				{
					float4 pos:SV_POSITION;
					float4 tex:TEXCOORD0;
				};
				vertexOutput vert(vertexInput input)
				{
					vertexOutput output;
					output.tex = input.tex;
					output.pos = mul(UNITY_MATRIX_MVP, input.vertex);
					return output;
				}
				float4 frag(vertexOutput input):COLOR
				{
					//return tex2D(_MainTex,input.tex);
					//just move the MainTex
					return tex2D(_MainTex,_MainTex_ST.xy*input.tex.xy + _MainTex_ST.zw);
				}

			ENDCG
		}
	}
		Fallback "Unlit/Texture"
}
