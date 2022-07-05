// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Grid1"
{
	Properties
	{
		_Size("Size", Range( 0.01 , 1)) = 0
		_TileScale("TileScale", Range( 1 , 100)) = 0
		_Color("Color", Color) = (1,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Color;
		uniform float _TileScale;
		uniform float _Size;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Emission = _Color.rgb;
			float4 appendResult164 = (float4(_TileScale , _TileScale , 0.0 , 0.0));
			float temp_output_2_0_g3 = _Size;
			float2 appendResult10_g4 = (float2(temp_output_2_0_g3 , temp_output_2_0_g3));
			float2 temp_output_11_0_g4 = ( abs( (frac( (i.uv_texcoord*appendResult164.xy + float2( 0,0 )) )*2.0 + -1.0) ) - appendResult10_g4 );
			float2 break16_g4 = ( 1.0 - ( temp_output_11_0_g4 / fwidth( temp_output_11_0_g4 ) ) );
			o.Alpha = (1.0 + (saturate( min( break16_g4.x , break16_g4.y ) ) - 0.0) * (0.0 - 1.0) / (1.0 - 0.0));
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
1920;0;1920;1029;1829.532;233.8029;1;True;True
Node;AmplifyShaderEditor.RangedFloatNode;163;-1840,320;Inherit;False;Property;_TileScale;TileScale;1;0;Create;True;0;0;0;False;0;False;0;50;1;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;162;-1547.532,488.1971;Inherit;False;Property;_Size;Size;0;0;Create;True;0;0;0;False;0;False;0;0.9;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;164;-1472,320;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;158;-1204.264,363.684;Inherit;True;Grid;-1;;3;a9240ca2be7e49e4f9fa3de380c0dbe9;0;3;5;FLOAT2;10,10;False;6;FLOAT2;0,0;False;2;FLOAT;0.88;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;157;-964.2639,363.684;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;160;-912,160;Inherit;False;Property;_Color;Color;2;0;Create;True;0;0;0;False;0;False;1,0,0,0;0.1603774,0.1603774,0.1603774,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-272,112;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;Grid1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;2;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;164;0;163;0
WireConnection;164;1;163;0
WireConnection;158;5;164;0
WireConnection;158;2;162;0
WireConnection;157;0;158;0
WireConnection;0;2;160;0
WireConnection;0;9;157;0
ASEEND*/
//CHKSM=255E77E33BDBD0DFF47B73A34104F32F706FFD4E