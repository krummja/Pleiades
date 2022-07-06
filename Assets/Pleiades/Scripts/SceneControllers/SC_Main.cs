using System.Collections;
using System.Collections.Generic;
using Architecture;
using Cinemachine;
using UnityEngine;
using Sirenix.OdinInspector;

public sealed class SA_Main : SceneArgs
{
}

[SceneControllerAttribute("PleiadesMain")]
public sealed class SC_Main : SceneController<SC_Main, SA_Main>
{
    [BoxGroup("Scene Configuration")] 
    public SceneConfig Config;
    
    public Camera Camera { get; private set; }

    protected override void OnAwake()
    {
        GameObject cameraObj = CameraManager.Instance.ActiveCamera;
        this.Camera = cameraObj.GetComponent<Camera>();
        CinemachineFreeLook cinemachine = cameraObj.GetComponent<CinemachineFreeLook>();

        Transform controller = GameObject.Find("ViewController").transform;
        cinemachine.Follow = cinemachine.LookAt = controller;
    }
}
