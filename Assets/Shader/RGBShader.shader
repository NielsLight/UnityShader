Shader "MyUnityShader/RGBShader"
{
	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			//debug shader 
			//the data bulit-in
			struct appdata_base
			{
				float4 vertex:POSITION;
				float3 normal:NORMAL;
				float4 tex:TEXCOORD0;
			};

			struct appdata_tan
			{
				float4 vertex:POSITION;
				float3 normal:NORMAL;
				float4 tex:TEXCOORD0;
				float3 tangent:TANGENT; 
			};

			struct appdata_full
			{
				float4 vertex:POSITION;
				float3 normal:NORMAL;
				float4 tangent:TANGENT;
				float4 tex1:TEXCOORD0;
				float4 tex2:TEXCOORD1;
				float4 col:COLOR;
			};
			//end
			struct v2f
			{
				float4 pos:SV_POSITION;
				float4 col:TEXCOORD0;
			};

			v2f vert(float4 vertexPos:POSITION)
			{
				v2f output;
				output.pos=mul(UNITY_MATRIX_MVP,vertexPos);
				output.col=vertexPos+float4(0.5,0.5,0.5,0);
				return output;
			}

			float4 frag(v2f IN):COLOR
			{
				return IN.col;
			}

			ENDCG
		}
	}
}
