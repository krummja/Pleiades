// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Grid"
{
	Properties
	{
		_PrimaryColor("Primary Color", Color) = (1,0,0,0)
		_SecondaryColor("Secondary Color", Color) = (1,0,0,0)
		_LineTint("Line Tint", Color) = (1,0,0,0)
		_NoiseScale("Noise Scale", Range( 0 , 10)) = 0
		_NoiseTextureOpacity("Noise Texture Opacity", Range( 0.01 , 1)) = 0
		_Radius("Radius", Range( 0.01 , 10)) = 0.01
		_LineWidth("Line Width", Range( 0 , 2)) = 0
		[HideInInspector]_Position("Position", Vector) = (0,0,0,0)
		_NoiseTexture("Noise Texture", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard alpha:fade keepalpha noshadow 
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			float2 uv_texcoord;
		};

		uniform sampler2D _NoiseTexture;
		uniform float _NoiseScale;
		uniform float3 _Position;
		uniform float _Radius;
		uniform float _LineWidth;
		uniform float _NoiseTextureOpacity;
		uniform float4 _PrimaryColor;
		uniform float4 _SecondaryColor;
		uniform float4 _LineTint;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float2 appendResult31 = (float2(ase_worldPos.x , ase_worldPos.y));
			float noiseScale49 = _NoiseScale;
			float4 nSide160 = tex2D( _NoiseTexture, ( ( appendResult31 + _Time.y ) * noiseScale49 ) );
			float2 appendResult41 = (float2(ase_worldPos.y , ase_worldPos.z));
			float4 nTop62 = tex2D( _NoiseTexture, ( ( appendResult41 + _Time.y ) * noiseScale49 ) );
			float3 ase_worldNormal = i.worldNormal;
			float3 temp_cast_0 = (4.0).xxx;
			float3 blendNormal58 = saturate( pow( ( ase_worldNormal * float3( 1.4,0,0 ) ) , temp_cast_0 ) );
			float4 lerpResult66 = lerp( nSide160 , nTop62 , blendNormal58.x);
			float4 noiseTexture_065 = lerpResult66;
			float2 appendResult36 = (float2(ase_worldPos.x , ase_worldPos.z));
			float4 nSide261 = tex2D( _NoiseTexture, ( ( appendResult36 + _Time.y ) * noiseScale49 ) );
			float4 lerpResult67 = lerp( noiseTexture_065 , nSide261 , blendNormal58.y);
			float4 noiseTexture74 = lerpResult67;
			float dis81 = distance( _Position , ase_worldPos );
			float sphere86 = ( 1.0 - saturate( ( dis81 / _Radius ) ) );
			float sphereNoise93 = ( noiseTexture74.r * sphere86 );
			float disLineWidth122 = _LineWidth;
			float DisAmount146 = _NoiseTextureOpacity;
			float temp_output_2_0_g1 = 0.86;
			float2 appendResult10_g2 = (float2(temp_output_2_0_g1 , temp_output_2_0_g1));
			float2 temp_output_11_0_g2 = ( abs( (frac( (i.uv_texcoord*float2( 10,10 ) + float2( 0,0 )) )*2.0 + -1.0) ) - appendResult10_g2 );
			float2 break16_g2 = ( 1.0 - ( temp_output_11_0_g2 / fwidth( temp_output_11_0_g2 ) ) );
			float4 c114 = ( (1.0 + (saturate( min( break16_g2.x , break16_g2.y ) ) - 0.0) * (0.0 - 1.0) / (1.0 - 0.0)) * _PrimaryColor );
			float4 primaryTex109 = ( step( ( sphereNoise93 - disLineWidth122 ) , DisAmount146 ) * c114 );
			float4 c2115 = _SecondaryColor;
			float4 secondaryTex110 = ( step( DisAmount146 , sphereNoise93 ) * c2115 );
			float DissolveLine_0100 = ( step( ( sphereNoise93 - disLineWidth122 ) , DisAmount146 ) * step( sphereNoise93 , DisAmount146 ) );
			float4 DissolveLine155 = ( DissolveLine_0100 * _LineTint );
			float4 resultTex111 = ( primaryTex109 + secondaryTex110 + DissolveLine155 );
			o.Albedo = resultTex111.rgb;
			o.Emission = DissolveLine155.rgb;
			o.Alpha = _PrimaryColor.a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
1916;33;1920;1029;3668.146;881.0679;1.377972;True;True
Node;AmplifyShaderEditor.CommentaryNode;85;-4528,-448;Inherit;False;1026;310;Blend Normal;6;59;55;58;56;57;53;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;84;-5168,-96;Inherit;False;1666;1161;Triplanar Map;29;42;46;47;28;31;26;43;41;40;51;52;15;49;29;50;44;39;34;37;36;38;32;14;60;61;62;151;152;153;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldPosInputsNode;43;-5120,752;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;53;-4480,-400;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldPosInputsNode;26;-5120,96;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;15;-5120,-32;Inherit;False;Property;_NoiseScale;Noise Scale;3;0;Create;True;0;0;0;False;0;False;0;0.27;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;31;-4896,96;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TimeNode;28;-5120,240;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;41;-4896,752;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;150;-5200,-416;Inherit;True;Property;_NoiseTexture;Noise Texture;8;0;Create;True;0;0;0;False;0;False;None;67f9b9363b45b4d3fb7b466648fe8fd1;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TimeNode;44;-5120,896;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;49;-4848,-32;Inherit;False;noiseScale;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;-4288,-400;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;1.4,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-4432,-256;Inherit;False;Constant;_Exp;Exp;15;0;Create;True;0;0;0;False;0;False;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;148;-4960,-416;Inherit;False;NoiseTex;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleAddOpNode;46;-4688,752;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;29;-4688,96;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;50;-4688,304;Inherit;False;49;noiseScale;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;51;-4688,960;Inherit;False;49;noiseScale;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;56;-4032,-400;Inherit;False;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;55;-3872,-400;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;-4336,752;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;153;-4336,672;Inherit;False;148;NoiseTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode;151;-4336,0;Inherit;False;148;NoiseTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WorldPosInputsNode;38;-5120,416;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-4336,96;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;83;-4128,1872;Inherit;False;626;377;Position;4;80;20;82;81;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TimeNode;37;-5120,560;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;14;-4048,96;Inherit;True;Property;_DissolveNoise;Dissolve Noise;4;0;Create;True;0;0;0;False;0;False;-1;None;67f9b9363b45b4d3fb7b466648fe8fd1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;36;-4896,416;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;58;-3728,-400;Inherit;True;blendNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;47;-4048,752;Inherit;True;Property;_TextureSample0;Texture Sample 0;6;1;[HideInInspector];Create;True;0;0;0;False;0;False;-1;None;67f9b9363b45b4d3fb7b466648fe8fd1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;73;-4352,1104;Inherit;False;850;369;;6;71;68;72;63;66;65;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;68;-4304,1312;Inherit;False;58;blendNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;34;-4688,416;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;52;-4688,624;Inherit;False;49;noiseScale;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;62;-3728,752;Inherit;False;nTop;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;60;-3728,96;Inherit;False;nSide1;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldPosInputsNode;82;-4080,2064;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;20;-4080,1920;Inherit;False;Property;_Position;Position;7;1;[HideInInspector];Create;True;0;0;0;False;0;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;-4336,416;Inherit;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;71;-4096,1312;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;72;-4304,1232;Inherit;False;62;nTop;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.DistanceOpNode;80;-3856,2000;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;63;-4304,1152;Inherit;False;60;nSide1;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;152;-4336,336;Inherit;False;148;NoiseTex;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;81;-3728,2000;Inherit;False;dis;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;66;-3904,1168;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;92;-4496,2272;Inherit;False;994;246;Sphere;7;87;88;89;86;90;17;91;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;79;-4354,1486;Inherit;False;850;369;;6;67;74;75;76;78;77;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;40;-4048,416;Inherit;True;Property;_TextureSample1;Texture Sample 1;5;1;[HideInInspector];Create;True;0;0;0;False;0;False;-1;None;67f9b9363b45b4d3fb7b466648fe8fd1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;91;-4448,2320;Inherit;False;81;dis;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;65;-3728,1168;Inherit;False;noiseTexture_0;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;61;-3728,416;Inherit;False;nSide2;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-4448,2400;Inherit;False;Property;_Radius;Radius;5;0;Create;True;0;0;0;False;0;False;0.01;3.37;0.01;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;78;-4304,1696;Inherit;False;58;blendNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;76;-4304,1616;Inherit;False;61;nSide2;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;77;-4096,1696;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;75;-4304,1536;Inherit;False;65;noiseTexture_0;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;90;-4160,2320;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;87;-4032,2320;Inherit;False;Constant;_Float0;Float 0;15;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;88;-4032,2400;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;67;-3904,1536;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;74;-3728,1536;Inherit;False;noiseTexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;98;-4224,2544;Inherit;False;726;294;Sphere Noise;5;93;96;94;95;97;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;89;-3872,2320;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;86;-3728,2320;Inherit;False;sphere;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;94;-4176,2592;Inherit;False;74;noiseTexture;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;95;-3984,2592;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;97;-4176,2672;Inherit;False;86;sphere;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;96;-3856,2592;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-5008,2768;Inherit;False;Property;_LineWidth;Line Width;6;0;Create;True;0;0;0;False;0;False;0;0.08;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;108;-5006,2864;Inherit;False;1521;436;Dissolve Line;12;155;107;19;156;100;106;99;105;103;104;123;101;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-3248,2672;Inherit;False;Property;_NoiseTextureOpacity;Noise Texture Opacity;4;0;Create;True;0;0;0;False;0;False;0;0.1359937;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;93;-3712,2592;Inherit;True;sphereNoise;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;122;-4688,2768;Inherit;False;disLineWidth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;101;-4958,2912;Inherit;False;93;sphereNoise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;146;-2928,2672;Inherit;False;DisAmount;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;143;-3312,-416;Inherit;False;755.9998;304;Grid;2;2;154;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;123;-4958,2992;Inherit;False;122;disLineWidth;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;104;-4958,3072;Inherit;False;146;DisAmount;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;103;-4574,2912;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;142;-2528,-416;Inherit;False;882;840;Input Textures;5;13;12;23;115;114;;1,1,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;154;-3104,-352;Inherit;True;Grid;-1;;1;a9240ca2be7e49e4f9fa3de380c0dbe9;0;3;5;FLOAT2;10,10;False;6;FLOAT2;0,0;False;2;FLOAT;0.86;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;130;-2928,1488;Inherit;False;978;326;Primary Texture;8;125;124;127;126;112;129;109;116;;1,1,1,1;0;0
Node;AmplifyShaderEditor.StepOpNode;99;-4382,2912;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;105;-4382,3072;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;2;-2864,-352;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;12;-2448,-176;Inherit;False;Property;_PrimaryColor;Primary Color;0;0;Create;True;0;0;0;False;0;False;1,0,0,0;1,0,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-2080,-288;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;-4206,2912;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;13;-2096,128;Inherit;False;Property;_SecondaryColor;Secondary Color;1;0;Create;True;0;0;0;False;0;False;1,0,0,0;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;135;-2752,1824;Inherit;False;802;326;Secondary Texture;6;131;132;133;117;134;110;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;124;-2880,1616;Inherit;False;122;disLineWidth;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;125;-2880,1536;Inherit;False;93;sphereNoise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;126;-2680,1536;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;115;-1872,128;Inherit;True;c2;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;127;-2879,1696;Inherit;False;146;DisAmount;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;132;-2704,1872;Inherit;False;146;DisAmount;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;114;-1872,-288;Inherit;True;c;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;100;-4032,2912;Inherit;False;DissolveLine_0;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;133;-2704,1952;Inherit;False;93;sphereNoise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;19;-4112,3104;Inherit;False;Property;_LineTint;Line Tint;2;0;Create;True;0;0;0;False;0;False;1,0,0,0;1,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;116;-2608,1696;Inherit;False;114;c;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;117;-2704,2032;Inherit;False;115;c2;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;112;-2528,1536;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;131;-2496,1872;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;156;-4112,3024;Inherit;False;100;DissolveLine_0;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;129;-2372,1537;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;107;-3904,3024;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;134;-2352,1872;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;109;-2176,1536;Inherit;True;primaryTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;155;-3696,3024;Inherit;True;DissolveLine;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;110;-2176,1872;Inherit;True;secondaryTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;141;-1302,-182;Inherit;False;648;320.0083;Result Texture;5;111;136;138;140;139;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;140;-1254,42;Inherit;False;155;DissolveLine;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;139;-1254,-38;Inherit;False;110;secondaryTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;138;-1254,-118;Inherit;False;109;primaryTex;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;136;-1024,-80;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;111;-870,-118;Inherit;True;resultTex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;144;-817,160;Inherit;False;155;DissolveLine;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-272,112;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Grid;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;2;5;False;-1;10;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;31;0;26;1
WireConnection;31;1;26;2
WireConnection;41;0;43;2
WireConnection;41;1;43;3
WireConnection;49;0;15;0
WireConnection;57;0;53;0
WireConnection;148;0;150;0
WireConnection;46;0;41;0
WireConnection;46;1;44;2
WireConnection;29;0;31;0
WireConnection;29;1;28;2
WireConnection;56;0;57;0
WireConnection;56;1;59;0
WireConnection;55;0;56;0
WireConnection;42;0;46;0
WireConnection;42;1;51;0
WireConnection;32;0;29;0
WireConnection;32;1;50;0
WireConnection;14;0;151;0
WireConnection;14;1;32;0
WireConnection;36;0;38;1
WireConnection;36;1;38;3
WireConnection;58;0;55;0
WireConnection;47;0;153;0
WireConnection;47;1;42;0
WireConnection;34;0;36;0
WireConnection;34;1;37;2
WireConnection;62;0;47;0
WireConnection;60;0;14;0
WireConnection;39;0;34;0
WireConnection;39;1;52;0
WireConnection;71;0;68;0
WireConnection;80;0;20;0
WireConnection;80;1;82;0
WireConnection;81;0;80;0
WireConnection;66;0;63;0
WireConnection;66;1;72;0
WireConnection;66;2;71;0
WireConnection;40;0;152;0
WireConnection;40;1;39;0
WireConnection;65;0;66;0
WireConnection;61;0;40;0
WireConnection;77;0;78;0
WireConnection;90;0;91;0
WireConnection;90;1;17;0
WireConnection;88;0;90;0
WireConnection;67;0;75;0
WireConnection;67;1;76;0
WireConnection;67;2;77;1
WireConnection;74;0;67;0
WireConnection;89;0;87;0
WireConnection;89;1;88;0
WireConnection;86;0;89;0
WireConnection;95;0;94;0
WireConnection;96;0;95;0
WireConnection;96;1;97;0
WireConnection;93;0;96;0
WireConnection;122;0;18;0
WireConnection;146;0;16;0
WireConnection;103;0;101;0
WireConnection;103;1;123;0
WireConnection;99;0;103;0
WireConnection;99;1;104;0
WireConnection;105;0;101;0
WireConnection;105;1;104;0
WireConnection;2;0;154;0
WireConnection;23;0;2;0
WireConnection;23;1;12;0
WireConnection;106;0;99;0
WireConnection;106;1;105;0
WireConnection;126;0;125;0
WireConnection;126;1;124;0
WireConnection;115;0;13;0
WireConnection;114;0;23;0
WireConnection;100;0;106;0
WireConnection;112;0;126;0
WireConnection;112;1;127;0
WireConnection;131;0;132;0
WireConnection;131;1;133;0
WireConnection;129;0;112;0
WireConnection;129;1;116;0
WireConnection;107;0;156;0
WireConnection;107;1;19;0
WireConnection;134;0;131;0
WireConnection;134;1;117;0
WireConnection;109;0;129;0
WireConnection;155;0;107;0
WireConnection;110;0;134;0
WireConnection;136;0;138;0
WireConnection;136;1;139;0
WireConnection;136;2;140;0
WireConnection;111;0;136;0
WireConnection;0;0;111;0
WireConnection;0;2;144;0
WireConnection;0;9;12;4
ASEEND*/
//CHKSM=6E5DC568C613D31750E2B98CA8E694542EEF9CBB