using System;
using Architecture;
using Cinemachine;
using DG.Tweening;
using UnityEngine;
using Sirenix.OdinInspector;


public class ViewController : MonoBehaviour
{
    // public GameObject Camera;
    public float DragSpeed = 2f;
    public float ScrollSpeed = 2f;
    public float TurnSpeed = 2f;

    private Vector3 dragOrigin;
    private Vector3 scrollOrigin;
    private Camera camera;
    private CinemachineFreeLook cinemachine;

    private void Awake()
    {
        this.camera = CameraManager.Instance.MainCamera.GetComponent<Camera>();
        this.cinemachine = CameraManager.Instance.MainCamera.GetComponent<CinemachineFreeLook>();
    }
    
    private void Update()
    {
        this.HandleZoomInput();
        this.HandlePanRotateInput();
    }

    private void HandleZoomInput()
    {
        // If CTRL is held, we want to zoom the current view plane.
        if (Input.GetButtonDown("CTRL")) cinemachine.m_YAxis.m_MaxSpeed = 0;
        
        // Otherwise, we want to zoom the camera between rigs.
        if (Input.GetButtonUp("CTRL")) cinemachine.m_YAxis.m_MaxSpeed = 1;
        
        if (Input.mouseScrollDelta.y != 0)
        {
            float scrollDelta = Input.mouseScrollDelta.y;

            // While we're holding CTRL...
            if (Input.GetButton("CTRL"))
            {
                // Compute the scroll speed and tween the Y axis translation.
                Vector3 scroll = new Vector3(0, scrollDelta * ScrollSpeed, 0);
                scrollOrigin = transform.position - scroll;
                transform.DOMoveY(scrollOrigin.y, 0.25f, false);    
            }
        }
    }

    private void HandlePanRotateInput()
    {
        // We want to update our origin if either mouse button is pressed.
        if (Input.GetMouseButtonDown(0) || Input.GetMouseButtonDown(1))
        {
            dragOrigin = Input.mousePosition;
            return;
        }

        // Then if we're not holding either, do nothing.
        if (!Input.GetMouseButton(0) && !Input.GetMouseButton(1)) return;
        
        // Get the offset from the drag origin to the new mouse position on the screen.
        Vector3 pos = this.camera.ScreenToViewportPoint(Input.mousePosition - dragOrigin);
        
        // If LMB is held, we're panning.
        if (Input.GetMouseButton(0))
        {
            Vector3 pan = new Vector3(pos.x * DragSpeed, 0, pos.y * DragSpeed);
            transform.Translate(pan, Space.Self);
        }
        
        // If RMB is held, we're rotating.
        if (Input.GetMouseButton(1))
        {
            Vector3 eulers = new Vector3(0, pos.x * TurnSpeed, 0);
            transform.Rotate(eulers);
        }
    }
}
