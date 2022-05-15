using UnityEngine;
using System.Collections;
using Sirenix.OdinInspector;

public class ExpressionSelector : MonoBehaviour
{
	public int matIDEyes = 1;
	public int matIDMouth = 2;

	[Range(0, 6)]
	public int mouthType = 0;

	[Range(0, 7)]
	public int eyeType = 0;

	// Use this for initialization
	void Start () {
		if (mouthType > 6) mouthType = 6;
		if (mouthType < 0) mouthType = 0;
		if (eyeType > 7) eyeType = 7;
		if (eyeType < 0) eyeType = 0;
	}
	
	// Update is called once per frame
	void Update () {
		switch (eyeType)
		{
		case 0:
			this.gameObject.GetComponent<Renderer> ().materials [matIDEyes].SetTextureOffset("_MainTex",new Vector2(0,0));
			break;
		case 1:
			this.gameObject.GetComponent<Renderer> ().materials [matIDEyes].SetTextureOffset("_MainTex",new Vector2(0,-0.125f));
			break;
		case 2:
			this.gameObject.GetComponent<Renderer> ().materials [matIDEyes].SetTextureOffset("_MainTex",new Vector2(0,-0.25f));
			break;
		case 3:
			this.gameObject.GetComponent<Renderer> ().materials [matIDEyes].SetTextureOffset("_MainTex",new Vector2(0,-0.375f));
			break;
		case 4:
			this.gameObject.GetComponent<Renderer> ().materials [matIDEyes].SetTextureOffset("_MainTex",new Vector2(0.25f,0));
			break;
		case 5:
			this.gameObject.GetComponent<Renderer> ().materials [matIDEyes].SetTextureOffset("_MainTex",new Vector2(0.25f,-0.125f));
			break;
		case 6:
			this.gameObject.GetComponent<Renderer> ().materials [matIDEyes].SetTextureOffset("_MainTex",new Vector2(0.25f,-0.25f));
			break;
		case 7:
			this.gameObject.GetComponent<Renderer> ().materials [matIDEyes].SetTextureOffset("_MainTex",new Vector2(0.25f,-0.375f));
			break;
		}
		switch (mouthType)
		{
		case 0:
			this.gameObject.GetComponent<Renderer> ().materials [matIDMouth].SetTextureOffset("_MainTex",new Vector2(0,0));
			break;
		case 1:
			this.gameObject.GetComponent<Renderer> ().materials [matIDMouth].SetTextureOffset("_MainTex",new Vector2(0,0.075f));
			break;
		case 2:
			this.gameObject.GetComponent<Renderer> ().materials [matIDMouth].SetTextureOffset("_MainTex",new Vector2(0,0.15f));
			break;
		case 3:
			this.gameObject.GetComponent<Renderer> ().materials [matIDMouth].SetTextureOffset("_MainTex",new Vector2(0,0.225f));
			break;
		case 4:
			this.gameObject.GetComponent<Renderer> ().materials [matIDMouth].SetTextureOffset("_MainTex",new Vector2(0.085f,0));
			break;
		case 5:
			this.gameObject.GetComponent<Renderer> ().materials [matIDMouth].SetTextureOffset("_MainTex",new Vector2(0.085f,0.075f));
			break;
		case 6:
			this.gameObject.GetComponent<Renderer> ().materials [matIDMouth].SetTextureOffset("_MainTex",new Vector2(0.085f,0.15f));
			break;
		}
	}

	public void selectEyeType(int type)
	{
		eyeType = type;
		if (eyeType > 7) eyeType = 7;
		if (eyeType < 0) eyeType = 0;
	}
	
	public void selectMouthType(int type)
	{
		mouthType = type;
		if (mouthType > 6) mouthType = 6;
		if (mouthType < 0) mouthType = 0;
	}
}
