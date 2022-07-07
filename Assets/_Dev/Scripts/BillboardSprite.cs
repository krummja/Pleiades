using System;
using Pleiades.__Architecture;
using UnityEngine;

public class BillboardSprite : MonoBehaviour
{
    private Transform camera;

    private void Awake()
    {
        this.camera = CameraManager.Instance.MainCamera.transform;
    }
    
    private void LateUpdate()
    {
        transform.LookAt(camera.transform.position);
    }
}
