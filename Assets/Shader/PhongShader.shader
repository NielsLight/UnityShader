Shader "MyUnityShader/PhongShader"
{
	Properties
	{
		_Color("diffuse color",Color) = (1,1,1,1)
		_SpecColor("specular color",Color)=(1,1,1,1)
		_Shininess("Shininess",Float)=10
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
				float4 _Color;
				float4 _SpecColor;
				float  _Shininess;

				struct vertexInput
				{
					float4 vertex:POSITION;
					float3 normal:NORMAL;
				};
				struct vertexOutput
				{
					float4 pos:SV_POSITION;
					float4 worldPos:TEXCOORD0;
					float4 worldNormal:TEXCOORD1;
				};

				vertexOutput vert(vertexInput input)
				{
					vertexOutput output;
					output.worldPos = mul(input.vertex,_World2Object);
					output.worldNormal = normalize(mul(_Object2World,float4(input.normal,0)));
					output.pos = mul(UNITY_MATRIX_MVP,input.vertex);
					return output;
				}
				float4 frag(vertexOutput input) :COLOR
				{
					float3 normal_dir = normalize(input.worldNormal);
					float3 view_dir = normalize(_WorldSpaceCameraPos.xyz - input.worldPos.xyz);
					float3 light_dir;
					float atten;
					if (0 == _WorldSpaceLightPos0.w)
					{
						atten = 1.0;
						light_dir = normalize(_WorldSpaceLightPos0.xyz);
					}
					else
					{
						float3 vertexToLight = _WorldSpaceLightPos0.xyz - input.worldPos.xyz;
						atten = 1.0 / length(vertexToLight);
						light_dir = normalize(vertexToLight);
					}
					float3 ambientColor = UNITY_LIGHTMODEL_AMBIENT.rgb*_Color.rgb;
					float3 diffuseColor = atten*_LightColor0.rgb*_Color.rgb*max(0,dot(normal_dir,light_dir));
					float3 specColor;
					if (dot(light_dir,normal_dir) < 0)
					{
						specColor = float3(0,0,0);
					}
					else
					{
						specColor = atten*_LightColor0.rgb*_SpecColor.rgb*pow(max(0,dot(reflect(-light_dir,normal_dir),view_dir)),_Shininess);
					}
					return float4(diffuseColor+specColor+ambientColor ,1.0);
				}

				ENDCG
			}

			Pass
			{
				Tags {"LightMode" = "ForwardAdd"}
				Blend One One
				
					CGPROGRAM
					#pragma vertex vert
					#pragma fragment frag

					uniform float4 _LightColor0;
					float4 _Color;
					float4 _SpecColor;
					float  _Shininess;

					struct vertexInput
					{
						float4 vertex:POSITION;
						float3 normal:NORMAL;
					};
					struct vertexOutput
					{
						float4 pos:SV_POSITION;
						float4 worldPos:TEXCOORD0;
						float4 worldNormal:TEXCOORD1;
					};

					vertexOutput vert(vertexInput input)
					{
						vertexOutput output;
						output.worldPos = mul(input.vertex,_World2Object);
						output.worldNormal = normalize(mul(_Object2World,float4(input.normal,0)));
						output.pos = mul(UNITY_MATRIX_MVP,input.vertex);
						return output;
					}
					float4 frag(vertexOutput input) :COLOR
					{
						float3 normal_dir = normalize(input.worldNormal);
						float3 view_dir = normalize(_WorldSpaceCameraPos.xyz - input.worldPos.xyz);
						float3 light_dir;
						float atten;
						if (0 == _WorldSpaceLightPos0.w)
						{
							atten = 1.0;
							light_dir = normalize(_WorldSpaceLightPos0.xyz);
						}
						else
						{
							float3 vertexToLight = _WorldSpaceLightPos0.xyz - input.worldPos.xyz;
							atten = 1.0 / length(vertexToLight);
							light_dir = normalize(vertexToLight);
						}
						float3 ambientColor = UNITY_LIGHTMODEL_AMBIENT.rgb*_Color.rgb;
						float3 diffuseColor = atten*_LightColor0.rgb*_Color.rgb*max(0,dot(normal_dir,light_dir));
						float3 specColor;
						if (dot(light_dir,normal_dir) < 0)
						{
							specColor = float3(0,0,0);
						}
						else
						{
							specColor = atten*_LightColor0.rgb*_SpecColor.rgb*pow(max(0,dot(reflect(-light_dir,normal_dir),view_dir)),_Shininess);
						}
						return float4(diffuseColor + specColor,1.0);
					}

					ENDCG
			
		}
	}
}
