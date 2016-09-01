Shader "MyUnityShader/BlendingWithTexture"
{
	Properties
	{
		_MainTex("RGBA Image Color",2D)="white"{}
		_Cutoff("Cutoff value",Range(0,2))=1
	}
	SubShader
	{
		Tags {"Queue"="Transparent"}
		Pass
		{
		Zwrite off //don't write to depth buffer //in order not to occlude other objects
		Cull back
		Blend SrcAlpha OneMinusSrcAlpha
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
			return tex2D(_MainTex,input.tex.xy)*_Cutoff;
		}
		
		ENDCG
		}
		Pass
		{
		Zwrite off //don't write to depth buffer //in order not to occlude other objects
		Cull front
		Blend SrcAlpha OneMinusSrcAlpha
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
			return tex2D(_MainTex,input.tex.xy)*_Cutoff;
		}
		
		
		
		ENDCG
		}
		
		
	}
}
