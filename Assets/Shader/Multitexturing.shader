Shader "MyUnityShader/Multitexturing"
{
	Properties
	{
		_DecalTex("daytime image color",2D)="white"{}
		_MainTex("night image color",2D)="white"{}
		_Color("night color filter",Color)=(1,1,1,1)
	}
	SubShader
	{
		Pass
		{
			Tags {"LightMode"="ForwardBase"}
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			uniform float4 _LightColor0;
			uniform sampler2D _DecalTex;
			uniform sampler2D _MainTex;
			uniform float4 _Color;
			struct vertexInput
			{
				float4 vertex:POSITION;
				float3 normal:NORMAL;
				float4 texcoord:TEXCOORD0;
			};
			struct vertexOutput
			{
				float4 pos:SV_POSITION;
				float4 tex:TEXCOORD0;
				float levelOfLighting:TEXCOORD1;
			};
			vertexOutput vert(vertexInput input)
			{
				vertexOutput output;
				output.pos=mul(UNITY_MATRIX_MVP,input.vertex);
				output.tex=input.texcoord;
				float3 normal_dir=normalize(mul(_Object2World,float4(input.normal,0)));
				float3 light_dir=normalize(_WorldSpaceLightPos0.xyz);
				output.levelOfLighting=max(0,dot(light_dir,normal_dir));
				return output;
			}
			float4 frag(vertexOutput input):COLOR
			{
				float4 nightColor=tex2D(_MainTex,input.tex.xy);
				float4 daytimeColor=tex2D(_DecalTex,input.tex.xy);
				return lerp(nightColor,daytimeColor,input.levelOfLighting);
				
			}
			
			ENDCG
		}
	}

}
