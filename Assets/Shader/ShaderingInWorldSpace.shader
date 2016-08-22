Shader "MyUnityShader/ShaderingInWorldSpace"
{
	Properties
	{
		_Point ("a point in world space",Vector)=(0.0,0.0,0.0,1)
		_Distance("threshold distance",Float)=0.5
		_ColorNear("color near to point",Color)=(0,1,0,1)
		_ColorFar("color far from point",Color)=(0,0,1,1)
	}
	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			float4 _Point;
			float _Distance;
			float4 _ColorNear;
			float4 _ColorFar;
			
			struct vertexOutput
			{
				float4 vertex:POSITION;
				float4 pos_in_world_space:TEXCOORD0;
			};
			vertexOutput vert(float4 vertex:POSITION)
			{
				vertexOutput Output;
				Output.vertex=mul(UNITY_MATRIX_MVP,vertex);
				Output.pos_in_world_space=mul(_Object2World,vertex);
				return Output;
			}
			float4 frag(vertexOutput IN):COLOR
			{
				float dist=distance(_Point,IN.pos_in_world_space);
				if(dist<_Distance)
				{
					return _ColorNear;
				}
				else
				{
					return _ColorFar;
				}
			}
			ENDCG
		}
	}
}