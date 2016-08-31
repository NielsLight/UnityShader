Shader "MyUnityShader/DiffuseShader"
{
	Properties
	{
		_Color("material diffuse color", Color) = (1,1,1,1)
	}
		SubShader
	{
		Pass
		{
			Tags { "LightMode"="ForwardBase" }
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			uniform float4 _LightColor0;
			float4 _Color;

			struct VertexInput
			{
				float4 vertex:POSITION;
				float3 normal:NORMAL;
			};
			struct VertexOutput
			{
				float4 pos:SV_POSITION;
				float4 col:COLOR;
			};
			VertexOutput vert(VertexInput IN)
			{
				VertexOutput OUT;
				OUT.pos = mul(UNITY_MATRIX_MVP, IN.vertex);
				float3 normal_dir = normalize(mul(float4(IN.normal,0),_World2Object)).xyz;
				float3 light_dir;
				float atten;
				//平行光
				if (_WorldSpaceLightPos0.w == 0)
				{
					atten = 1.0;
					light_dir = normalize(_WorldSpaceLightPos0.xyz);
				}
				else
				{
					float3 dir = _WorldSpaceLightPos0.xyz - mul(IN.vertex, _World2Object).xyz;
					atten = 1.0 / length(dir);
					light_dir = normalize(dir);
				}
				float3 diffuse = _LightColor0.rgb*_Color.rgb*max(0, dot(light_dir, normal_dir))*atten;
				OUT.col = float4(diffuse, 1.0);
				return OUT;
			}
			float4 frag(VertexOutput IN):COLOR
			{
				return IN.col;
			}

			ENDCG
		}
		Pass
			{
			Tags{ "LightMode" = "ForwardAdd" }
			Blend One One
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			uniform float4 _LightColor0;
			float4 _Color;

			struct VertexInput
			{
				float4 vertex:POSITION;
				float3 normal:NORMAL;
			};
			struct VertexOutput
			{
				float4 pos:SV_POSITION;
				float4 col:COLOR;
			};
			VertexOutput vert(VertexInput IN)
			{
				VertexOutput OUT;
				OUT.pos = mul(UNITY_MATRIX_MVP, IN.vertex);
				float3 normal_dir = normalize(mul(float4(IN.normal,0),_World2Object)).xyz;
				float3 light_dir;
				float atten;
				//平行光
				if (_WorldSpaceLightPos0.w == 0)
				{
					atten = 1.0;
					light_dir = normalize(_WorldSpaceLightPos0.xyz);
				}
				else
				{
					float3 dir = _WorldSpaceLightPos0.xyz - mul(IN.vertex, _World2Object).xyz;
					atten = 1.0 / length(dir);
					light_dir = normalize(dir);
				}
				float3 diffuse = _LightColor0.rgb*_Color.rgb*max(0, dot(light_dir, normal_dir))*atten;
				OUT.col = float4(diffuse, 1.0);
				return OUT;
			}
			float4 frag(VertexOutput IN) :COLOR
			{
				return IN.col;
			}

				ENDCG
			}
	}
}
