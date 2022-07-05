// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hologram"
{
	Properties
	{
		_MapTexture("Map Texture", 2D) = "white" {}
		_EmissionPower("Emission Power", Float) = 0
		_EmissionColor("Emission Color", Color) = (1,0,0,0)
		_OutlinePower("Outline Power", Float) = 0
		_OutlinePulseSpeed("Outline Pulse Speed", Float) = 0
		_RimPower("Rim Power", Range( 0 , 10)) = 0
		_BackfaceOpacity("Backface Opacity", Float) = 0
		_OpacityModifier("Opacity Modifier", Range( -3 , 3)) = 0.1
		_GridPower("Grid Power", Float) = 0
		_GridPulseSpeed("Grid Pulse Speed", Float) = 0
		_PatternTexture("Pattern Texture", 2D) = "white" {}
		_PatternPower("Pattern Power", Float) = 0
		_PatternScrollspeed("Pattern Scrollspeed", Float) = 0
		_DistortionLineTexture("Distortion Line Texture", 2D) = "white" {}
		_DistortionLinePower("Distortion Line Power", Range( 0 , 0.05)) = 0
		_DistortionLineMult("Distortion Line Mult", Float) = 0
		_DistortionTimeScale("Distortion Time Scale", Float) = 0
		_DistortionScrollSpeed("Distortion Scroll Speed", Float) = 0
		_DistortionPanSpeed1("Distortion Pan Speed 1", Vector) = (0,0,0,0)
		_DistortionPanSpeed2("Distortion Pan Speed 2", Vector) = (0,0,0,0)
		_ScanlineSpeed("Scanline Speed", Float) = 1
		_ScanlineOpacity("Scanline Opacity", Range( 0 , 1)) = 1
		_ScanlineWidth("Scanline Width", Float) = 10
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
		#pragma surface surf Unlit alpha:fade keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
			half ASEVFace : VFACE;
			float3 viewDir;
		};

		uniform float4 _EmissionColor;
		uniform float _GridPulseSpeed;
		uniform sampler2D _MapTexture;
		uniform float _DistortionTimeScale;
		uniform float2 _DistortionPanSpeed1;
		uniform sampler2D _DistortionLineTexture;
		uniform float _DistortionScrollSpeed;
		uniform float2 _DistortionPanSpeed2;
		uniform float _DistortionLinePower;
		uniform float _DistortionLineMult;
		uniform float _BackfaceOpacity;
		uniform float _GridPower;
		uniform float _OutlinePower;
		uniform float _OutlinePulseSpeed;
		uniform sampler2D _PatternTexture;
		uniform float _PatternScrollspeed;
		uniform float _PatternPower;
		uniform float _OpacityModifier;
		uniform float _RimPower;
		uniform float _ScanlineWidth;
		uniform float _ScanlineSpeed;
		uniform float _ScanlineOpacity;
		uniform float _EmissionPower;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Emission = _EmissionColor.rgb;
			float T20149 = _Time.x;
			float2 panner127 = ( ( _DistortionScrollSpeed * _Time.y ) * _DistortionPanSpeed2 + i.uv_texcoord);
			float temp_output_134_0 = ( ( 1.0 - tex2D( _DistortionLineTexture, panner127 ).r ) * _DistortionLinePower );
			float2 appendResult140 = (float2(( saturate( i.uv_texcoord.x ) + ( temp_output_134_0 * _DistortionLineMult ) ) , ( i.uv_texcoord.y + temp_output_134_0 )));
			float2 DistortionUV143 = appendResult140;
			float2 panner139 = ( ( _DistortionTimeScale * T20149 ) * _DistortionPanSpeed1 + DistortionUV143);
			float2 DistortionPan142 = panner139;
			float4 tex2DNode45 = tex2D( _MapTexture, DistortionPan142 );
			float switchResult35 = (((i.ASEVFace>0)?(tex2DNode45.g):(( tex2DNode45.g * _BackfaceOpacity ))));
			float Green68 = switchResult35;
			float temp_output_59_0 = ( (1.0 + (sin( ( _Time.y * _GridPulseSpeed ) ) - 0.0) * (0.0 - 1.0) / (1.0 - 0.0)) * Green68 );
			float4 tex2DNode46 = tex2D( _MapTexture, DistortionUV143 );
			float switchResult36 = (((i.ASEVFace>0)?(tex2DNode46.b):(( tex2DNode46.b * _BackfaceOpacity ))));
			float Blue69 = switchResult36;
			float lerpResult57 = lerp( ( temp_output_59_0 * 0.0 ) , temp_output_59_0 , ( 1.0 - Blue69 ));
			float Lines11 = ( saturate( lerpResult57 ) * _GridPower );
			float switchResult34 = (((i.ASEVFace>0)?(tex2DNode46.r):(( tex2DNode46.r * _BackfaceOpacity ))));
			float Red67 = switchResult34;
			float switchResult37 = (((i.ASEVFace>0)?(tex2DNode46.a):(( tex2DNode46.a * _BackfaceOpacity ))));
			float Alpha70 = switchResult37;
			float GlowClock15 = ( Alpha70 * (1.0 + (sin( ( _Time.y * _OutlinePulseSpeed ) ) - 0.0) * (0.0 - 1.0) / (1.0 - 0.0)) );
			float2 appendResult114 = (float2(-1.0 , -1.0));
			float2 panner118 = ( ( _Time.x * _PatternScrollspeed ) * appendResult114 + i.uv_texcoord);
			float Pattern14 = ( Blue69 * ( 1.0 - tex2D( _PatternTexture, panner118 ).r ) * _PatternPower );
			float4 color84 = IsGammaSpace() ? float4(0,0,1,0) : float4(0,0,1,0);
			float3 normalizeResult86 = normalize( i.viewDir );
			float dotResult83 = dot( color84 , float4( normalizeResult86 , 0.0 ) );
			float switchResult75 = (((i.ASEVFace>0)?(pow( ( 1.0 - saturate( dotResult83 ) ) , _RimPower )):(0.0)));
			float Rim10 = switchResult75;
			float GlowDiff8 = (_ScanlineOpacity + (sin( ( _ScanlineWidth * ( i.uv_texcoord.y + ( _Time.x * _ScanlineSpeed ) ) * 6.28318548202515 ) ) - 0.0) * (0.0 - _ScanlineOpacity) / (1.0 - 0.0));
			o.Alpha = ( ( ( ( Lines11 + ( ( ( ( Red67 * _OutlinePower ) + GlowClock15 ) + ( ( Green68 * 0.0 ) + Pattern14 ) ) + _OpacityModifier ) ) + Rim10 ) * GlowDiff8 ) * _EmissionPower );
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
1920;0;1920;1029;2386.096;411.3177;1.466794;True;True
Node;AmplifyShaderEditor.CommentaryNode;141;-5616,-1344;Inherit;False;2637;680;Distortion;26;143;142;133;139;132;131;134;135;138;129;130;128;137;140;136;127;123;126;125;124;144;149;150;151;152;153;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TimeNode;126;-5552,-912;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;124;-5584,-1008;Inherit;False;Property;_DistortionScrollSpeed;Distortion Scroll Speed;17;0;Create;True;0;0;0;False;0;False;0;0.39;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;153;-5584,-1136;Inherit;False;Property;_DistortionPanSpeed2;Distortion Pan Speed 2;19;0;Create;True;0;0;0;False;0;False;0,0;1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;125;-5216,-880;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;123;-5568,-1264;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;127;-4976,-1008;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;128;-4768,-1008;Inherit;True;Property;_DistortionLineTexture;Distortion Line Texture;13;0;Create;True;0;0;0;False;0;False;-1;None;508047cfbe8f5834eb92ff2b0d54edf8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;131;-4416,-912;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;130;-4768,-800;Inherit;False;Property;_DistortionLinePower;Distortion Line Power;14;0;Create;True;0;0;0;False;0;False;0;0.0087;0;0.05;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;134;-4224,-864;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;151;-4307.605,-744.0674;Inherit;False;Property;_DistortionLineMult;Distortion Line Mult;15;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;129;-4768,-1136;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;135;-4032,-864;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;138;-4224,-992;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;137;-3840,-1088;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;136;-3840,-992;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;140;-3680,-1056;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;149;-5216,-768;Inherit;False;T20;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;143;-3376,-1008;Inherit;False;DistortionUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;132;-4512,-1248;Inherit;False;Property;_DistortionTimeScale;Distortion Time Scale;16;0;Create;True;0;0;0;False;0;False;0;3.9;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;150;-4512,-1152;Inherit;False;149;T20;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;152;-4032,-1280;Inherit;False;Property;_DistortionPanSpeed1;Distortion Pan Speed 1;18;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;-4192,-1200;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;144;-3776,-1280;Inherit;False;143;DistortionUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;139;-3504,-1248;Inherit;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0.1,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;142;-3232,-1248;Inherit;False;DistortionPan;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;33;-4624,-160;Inherit;False;1649.775;583.6818;Backface;18;38;67;34;29;69;70;37;36;68;35;31;32;30;46;45;146;145;47;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;145;-4576,144;Inherit;False;142;DistortionPan;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;47;-4576,-80;Inherit;True;Property;_MapTexture;Map Texture;0;0;Create;True;0;0;0;False;0;False;None;bdb475a0ec56e0542a9dd16eaa328564;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.RangedFloatNode;38;-4272,320;Inherit;False;Property;_BackfaceOpacity;Backface Opacity;6;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;45;-4272,-80;Inherit;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;66;-5376,-640;Inherit;False;2397.879;451.8481;Lines;15;72;71;60;65;64;63;62;61;59;58;57;56;54;53;11;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;146;-4576,240;Inherit;False;143;DistortionUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;120;-4800,1840;Inherit;False;1858;614;Pattern;14;14;117;112;116;110;109;114;119;118;108;115;111;113;121;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;111;-4736,2336;Inherit;False;Property;_PatternScrollspeed;Pattern Scrollspeed;12;0;Create;True;0;0;0;False;0;False;0;0.36;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;110;-4688,2016;Inherit;False;Constant;_PatternU;Pattern U;8;0;Create;True;0;0;0;False;0;False;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;46;-4272,112;Inherit;True;Property;_TextureSample1;Texture Sample 1;3;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;65;-5312,-416;Inherit;False;Property;_GridPulseSpeed;Grid Pulse Speed;9;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;115;-4736,2176;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;109;-4688,2096;Inherit;False;Constant;_PatternV;Pattern V;8;0;Create;True;0;0;0;False;0;False;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;94;-4256,880;Inherit;False;1293.3;346.0999;Glow Clock;8;15;92;91;122;90;89;93;88;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TimeNode;64;-5312,-560;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-3616,0;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;113;-4480,2224;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;35;-3392,0;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-3616,192;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;114;-4496,2016;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;93;-4192,1104;Inherit;False;Property;_OutlinePulseSpeed;Outline Pulse Speed;4;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;88;-4192,944;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;-5008,-560;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-3616,96;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;108;-4576,1888;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;118;-4288,2048;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;68;-3168,0;Inherit;False;Green;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;37;-3392,192;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;62;-4864,-560;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;89;-3951,1007;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;36;-3392,96;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;87;-4716.223,455.4225;Inherit;False;1746;414;Rim;11;10;75;74;76;79;81;77;83;84;86;85;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TFHCRemapNode;61;-4688,-560;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;90;-3792,1008;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;-4688,-384;Inherit;False;68;Green;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;85;-4668.223,679.4225;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;119;-4016,2048;Inherit;True;Property;_PatternTexture;Pattern Texture;10;0;Create;True;0;0;0;False;0;False;-1;None;2a0bc652b6bfdeb45a898cbcc3790065;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;70;-3168,192;Inherit;False;Alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;69;-3168,96;Inherit;False;Blue;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-3616,-96;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;122;-3616,928;Inherit;False;70;Alpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;121;-3632,1952;Inherit;False;69;Blue;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;86;-4444.223,663.4225;Inherit;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;72;-4688,-304;Inherit;False;69;Blue;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;34;-3392,-96;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;112;-3632,2128;Inherit;False;Property;_PatternPower;Pattern Power;11;0;Create;True;0;0;0;False;0;False;0;7.56;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;107;-4512,1248;Inherit;False;1565;565;Glow Diff;12;106;98;8;95;104;97;103;105;101;96;102;148;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;-4384,-496;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;84;-4668.223,503.4225;Inherit;False;Constant;_NormalColor;Normal Color;7;0;Create;True;0;0;0;False;0;False;0,0,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;91;-3616,1008;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;116;-3616,2048;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;50;-2887,-80;Inherit;False;407.759;232;World Outline;3;48;49;73;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;92;-3312,976;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;102;-4480,1584;Inherit;False;Property;_ScanlineSpeed;Scanline Speed;20;0;Create;True;0;0;0;False;0;False;1;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;60;-4128,-416;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;117;-3328,1984;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;58;-4128,-576;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;96;-4480,1440;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;67;-3168,-96;Inherit;False;Red;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;52;-2426,-17;Inherit;False;1039;476;;9;147;24;25;26;27;21;28;20;19;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DotProductOpNode;83;-4256,544;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-3152,1984;Inherit;False;Pattern;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;101;-4480,1312;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;48;-2855,64;Inherit;False;Property;_OutlinePower;Outline Power;3;0;Create;True;0;0;0;False;0;False;0;30.48;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;73;-2855,-16;Inherit;False;67;Red;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;57;-3872,-512;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;15;-3168,976;Inherit;False;GlowClock;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;147;-2400,176;Inherit;False;68;Green;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;105;-4224,1504;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;81;-4096,544;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TauNode;104;-4016,1536;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;79;-3920,544;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;56;-3712,-512;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-3712,-432;Inherit;False;Property;_GridPower;Grid Power;8;0;Create;True;0;0;0;False;0;False;0;4.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;19;-2400,96;Inherit;False;15;GlowClock;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-2160,176;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;77;-4076.223,663.4225;Inherit;False;Property;_RimPower;Rim Power;5;0;Create;True;0;0;0;False;0;False;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;20;-2400,336;Inherit;False;14;Pattern;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;103;-4064,1360;Inherit;False;Property;_ScanlineWidth;Scanline Width;22;0;Create;True;0;0;0;False;0;False;10;26.87;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;97;-4016,1440;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;-2615,0;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;-3424,-496;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;-3872,1408;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;76;-3692.223,663.4225;Inherit;False;Constant;_Backface;Backface;6;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;27;-1984,240;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;74;-3692.223,567.4225;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;21;-1984,80;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;51;-1344,-16;Inherit;False;1076;406;;8;16;18;6;5;7;2;4;3;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;26;-1749,79;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-1993,352;Inherit;False;Property;_OpacityModifier;Opacity Modifier;7;0;Create;True;0;0;0;False;0;False;0.1;0.68;-3;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;75;-3420.222,599.4225;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;11;-3200,-496;Inherit;False;Lines;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;148;-3840,1632;Inherit;False;Property;_ScanlineOpacity;Scanline Opacity;21;0;Create;True;0;0;0;False;0;False;1;0.022;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;106;-3744,1408;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;10;-3196.223,599.4225;Inherit;False;Rim;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;16;-1296,48;Inherit;False;11;Lines;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-1525,95;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;95;-3440,1408;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.19;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;18;-1296,208;Inherit;False;10;Rim;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;6;-1056,64;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;8;-3168,1392;Inherit;False;GlowDiff;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;5;-848,112;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;7;-1296,288;Inherit;False;8;GlowDiff;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-704,272;Inherit;False;Property;_EmissionPower;Emission Power;1;0;Create;True;0;0;0;False;0;False;0;1.95;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-656,160;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;-464,-192;Inherit;False;Property;_EmissionColor;Emission Color;2;0;Create;True;0;0;0;False;0;False;1,0,0,0;1,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-432,192;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;Hologram;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.61;True;False;0;False;Transparent;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;1;1;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;125;0;124;0
WireConnection;125;1;126;2
WireConnection;127;0;123;0
WireConnection;127;2;153;0
WireConnection;127;1;125;0
WireConnection;128;1;127;0
WireConnection;131;0;128;1
WireConnection;134;0;131;0
WireConnection;134;1;130;0
WireConnection;135;0;134;0
WireConnection;135;1;151;0
WireConnection;138;0;129;1
WireConnection;137;0;129;2
WireConnection;137;1;134;0
WireConnection;136;0;138;0
WireConnection;136;1;135;0
WireConnection;140;0;136;0
WireConnection;140;1;137;0
WireConnection;149;0;126;1
WireConnection;143;0;140;0
WireConnection;133;0;132;0
WireConnection;133;1;150;0
WireConnection;139;0;144;0
WireConnection;139;2;152;0
WireConnection;139;1;133;0
WireConnection;142;0;139;0
WireConnection;45;0;47;0
WireConnection;45;1;145;0
WireConnection;46;0;47;0
WireConnection;46;1;146;0
WireConnection;30;0;45;2
WireConnection;30;1;38;0
WireConnection;113;0;115;1
WireConnection;113;1;111;0
WireConnection;35;0;45;2
WireConnection;35;1;30;0
WireConnection;32;0;46;4
WireConnection;32;1;38;0
WireConnection;114;0;110;0
WireConnection;114;1;109;0
WireConnection;63;0;64;2
WireConnection;63;1;65;0
WireConnection;31;0;46;3
WireConnection;31;1;38;0
WireConnection;118;0;108;0
WireConnection;118;2;114;0
WireConnection;118;1;113;0
WireConnection;68;0;35;0
WireConnection;37;0;46;4
WireConnection;37;1;32;0
WireConnection;62;0;63;0
WireConnection;89;0;88;2
WireConnection;89;1;93;0
WireConnection;36;0;46;3
WireConnection;36;1;31;0
WireConnection;61;0;62;0
WireConnection;90;0;89;0
WireConnection;119;1;118;0
WireConnection;70;0;37;0
WireConnection;69;0;36;0
WireConnection;29;0;46;1
WireConnection;29;1;38;0
WireConnection;86;0;85;0
WireConnection;34;0;46;1
WireConnection;34;1;29;0
WireConnection;59;0;61;0
WireConnection;59;1;71;0
WireConnection;91;0;90;0
WireConnection;116;0;119;1
WireConnection;92;0;122;0
WireConnection;92;1;91;0
WireConnection;60;0;72;0
WireConnection;117;0;121;0
WireConnection;117;1;116;0
WireConnection;117;2;112;0
WireConnection;58;0;59;0
WireConnection;67;0;34;0
WireConnection;83;0;84;0
WireConnection;83;1;86;0
WireConnection;14;0;117;0
WireConnection;57;0;58;0
WireConnection;57;1;59;0
WireConnection;57;2;60;0
WireConnection;15;0;92;0
WireConnection;105;0;96;1
WireConnection;105;1;102;0
WireConnection;81;0;83;0
WireConnection;79;0;81;0
WireConnection;56;0;57;0
WireConnection;28;0;147;0
WireConnection;97;0;101;2
WireConnection;97;1;105;0
WireConnection;49;0;73;0
WireConnection;49;1;48;0
WireConnection;53;0;56;0
WireConnection;53;1;54;0
WireConnection;98;0;103;0
WireConnection;98;1;97;0
WireConnection;98;2;104;0
WireConnection;27;0;28;0
WireConnection;27;1;20;0
WireConnection;74;0;79;0
WireConnection;74;1;77;0
WireConnection;21;0;49;0
WireConnection;21;1;19;0
WireConnection;26;0;21;0
WireConnection;26;1;27;0
WireConnection;75;0;74;0
WireConnection;75;1;76;0
WireConnection;11;0;53;0
WireConnection;106;0;98;0
WireConnection;10;0;75;0
WireConnection;24;0;26;0
WireConnection;24;1;25;0
WireConnection;95;0;106;0
WireConnection;95;3;148;0
WireConnection;6;0;16;0
WireConnection;6;1;24;0
WireConnection;8;0;95;0
WireConnection;5;0;6;0
WireConnection;5;1;18;0
WireConnection;4;0;5;0
WireConnection;4;1;7;0
WireConnection;3;0;4;0
WireConnection;3;1;2;0
WireConnection;0;2;1;0
WireConnection;0;9;3;0
ASEEND*/
//CHKSM=EB0D47558E2A2268528F7A80B85FC1BCD254B26D