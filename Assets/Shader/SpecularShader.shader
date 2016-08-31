Shader "MyUnityShader/SpecularShader"
{
	Properties
	{
		_DiffColor("Diffuse material color",Color) = (1,1,1,1)
		_SpecColor("Specular material color", Color) = (1, 1, 1, 1)
		_Shininess("Shininess", Float) = 10
	}
		SubShader
	{
		Tags {"LightMode" = "ForwardBase"}
		Pass
		{
			CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				uniform float4 _LightColor0;
				float4 _DiffColor;
				float4 _SpecColor;
				float _Shininess;
				struct vertexInput
				{
					float4 vertex:POSITION;
					float3 normal:NORMAL;
				};
				struct vertexOutput
				{
					float4 pos:SV_POSITION;
					float4 col:COLOR;
				};
				vertexOutput vert(vertexInput IN)
				{
					vertexOutput OUT;
					OUT.pos = mul(UNITY_MATRIX_MVP, IN.vertex);
					float3 normal_dir = normalize(mul(float4(IN.normal, 0), _World2Object).xyz);
					float3 view_dir = normalize(_WorldSpaceCameraPos.xyz - mul(IN.vertex, _World2Object).xyz);
					/*float3 reflect_dir = reflect(light_dir, normal_dir);*/
					float3 light_dir;
					//衰减系数
					float atten;
					//diffuse color
					if (_WorldSpaceLightPos0.w == 0)
					{
						atten = 1.0;
						light_dir = normalize(_WorldSpaceLightPos0.xyz);
					}
					else
					{
						float3 vertexToLight = _WorldSpaceLightPos0.xyz - mul(IN.vertex, _World2Object).xyz;
						atten = 1.0 / length(vertexToLight);
						light_dir = normalize(vertexToLight);
					}
					//ambient color
					float3 ambientColor = UNITY_LIGHTMODEL_AMBIENT.rgb*_DiffColor.rgb;
					float3 diffuseColor = _LightColor0.rgb*_DiffColor.rgb*max(0, dot(light_dir, normal_dir))*atten;
					float3 specColor;
					//specular color
					if (dot(light_dir, normal_dir)<0)
					{
						specColor = float3(0, 0, 0);
					}
					else
					{
						specColor = _LightColor0.rgb*_SpecColor.rgb*atten*pow(max(0, dot(reflect(-light_dir, normal_dir), view_dir)), _Shininess);
					}
					//merge the three color
					float3 color = ambientColor + diffuseColor + specColor;
					OUT.col = float4(color, 1.0);
					return OUT;
				}
				//just output color
				float4 frag(vertexOutput IN):COLOR
				{
					return IN.col;
				}
			ENDCG
		}
		Pass
				{
					CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				uniform float4 _LightColor0;
				float4 _DiffColor;
				float4 _SpecColor;
				float _Shininess;
				struct vertexInput
				{
					float4 vertex:POSITION;
					float3 normal:NORMAL;
				};
				struct vertexOutput
				{
					float4 pos:SV_POSITION;
					float4 col:COLOR;
				};
				vertexOutput vert(vertexInput IN)
				{
					vertexOutput OUT;
					OUT.pos = mul(UNITY_MATRIX_MVP, IN.vertex);
					float3 normal_dir = normalize(mul(float4(IN.normal, 0), _World2Object).xyz);
					float3 view_dir = normalize(_WorldSpaceCameraPos.xyz - mul(IN.vertex, _World2Object).xyz);
					/*float3 reflect_dir = reflect(light_dir, normal_dir);*/
					float3 light_dir;
					float atten;
					//diffuse color
					if (_WorldSpaceLightPos0.w == 0)
					{
						atten = 1.0;
						light_dir = normalize(_WorldSpaceLightPos0.xyz);
					}
					else
					{
						float3 vertexToLight = _WorldSpaceLightPos0.xyz - mul(IN.vertex, _World2Object).xyz;
						atten = 1.0 / length(vertexToLight);
						light_dir = normalize(vertexToLight);
					}
					//ambient color
					float3 ambientColor = UNITY_LIGHTMODEL_AMBIENT.rgb*_DiffColor.rgb;
					float3 diffuseColor = _LightColor0.rgb*_DiffColor.rgb*max(0, dot(light_dir, normal_dir))*atten;
					float3 specColor;
					//specular color
					if (dot(light_dir, normal_dir)<0)
					{
						specColor = float3(0, 0, 0);
					}
					else
					{
						specColor = _LightColor0.rgb*_SpecColor.rgb*atten*pow(max(0, dot(reflect(-light_dir, normal_dir), view_dir)), _Shininess);
					}
					//merge the three color
					//no ambient color in this pass
					float3 color =  diffuseColor + specColor;
					OUT.col = float4(color, 1.0);
					return OUT;
				}
				//just output color
				float4 frag(vertexOutput IN) :COLOR
				{
					return IN.col;
				}
					ENDCG
				}
	}
}
