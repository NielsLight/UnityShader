Shader "MyUnityShader/AlphaDiscardWithTex"
{
	Properties
	{
		_MainTex("RGBA Image Color",2D)="White"{}
		_Cutoff("Cutoff value",Range(0,1))=0.5
	}
	SubShader
	{
		Cull off
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			uniform sampler2D _MainTex;
			uniform float _Cutoff;
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
				output.pos=mul(UNITY_MATRIX_MVP,input.vertex);
				output.tex=input.tex;
				return output;
			}
			float4 frag(vertexOutput input):COLOR
			{
				float4 color=tex2D(_MainTex,input.tex.xy);
				if(color.a<_Cutoff)
				{
					 discard;
				}
				return color;
			}
			
			ENDCG
		}
	}
	//Fallback "Transparent Cutout"
}
