Shader "MyUnityShader/BetterCutaway"
{
	SubShader
	{
		Pass
		{
			Cull front 
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			struct vertexOutput
			{
				float4 vertex:SV_POSITION;
				float4 posInObjectCoord:TEXCOORD0;
			};
			vertexOutput vert(float4 vertex:POSITION)
			{
				vertexOutput Output;
				Output.vertex=mul(UNITY_MATRIX_MVP,vertex);
				Output.posInObjectCoord=vertex;
				return Output;
			}
			float4 frag(vertexOutput IN):COLOR
			{
				if(IN.posInObjectCoord.y>0.0)
					discard;
				return float4(1,0,0,1);
			}
			ENDCG
		}
		Pass
		{
			Cull back 
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			struct vertexOutput
			{
				float4 vertex:SV_POSITION;
				float4 posInObjectCoord:TEXCOORD0;
			};
			vertexOutput vert(float4 vertex:POSITION)
			{
				vertexOutput Output;
				Output.vertex=mul(UNITY_MATRIX_MVP,vertex);
				Output.posInObjectCoord=vertex;
				return Output;
			}
			float4 frag(vertexOutput IN):COLOR
			{
				if(IN.posInObjectCoord.y>0.0)
					discard;
				return float4(0,1,0,1);
			}
			ENDCG
		}
	}
}
