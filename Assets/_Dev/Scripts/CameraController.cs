using System;
using Architecture;
using DG.Tweening;
using UnityEngine;

public enum CameraMode
{
    VectorPan,
    ClickPan,
}

public class CameraController : MonoBehaviour
{
    public Camera Camera;
    public CameraMode CameraMode;
    public float DragSpeed = 2f;
    public float ScrollSpeed = 2f;

    private Vector3 groundCamOffset;
    private Vector3 camTarget;
    private Vector3 dragOrigin;

    private void Awake()
    {
        this.CameraMode = CameraMode.VectorPan;
    }
    
    private void Update()
    {
        if (Input.GetKey("CTRL") && Input.mouseScrollDelta.y != 0f)
        {
            float scrollDelta = Input.mouseScrollDelta.y;
            Vector3 move = new Vector3(0, scrollDelta * ScrollSpeed, 0);
            groundCamOffset = transform.position - move;
            transform.DOMoveY(groundCamOffset.y, 0.25f, false);
        }
        
        if (this.CameraMode == CameraMode.VectorPan)
        {
            if (Input.GetMouseButtonDown(0))
            {
                dragOrigin = Input.mousePosition;
                return;
            }

            if (!Input.GetMouseButton(0)) return;

            Vector3 pos = Camera.ScreenToViewportPoint(Input.mousePosition - dragOrigin);
            // Use the mouse's on-screen x/y delta to drive the drag motion.
            Vector3 move = new Vector3(pos.x * DragSpeed, 0, pos.y * DragSpeed);
            transform.Translate(move, Space.World);
        }
    }

    private void OnDrawGizmos()
    {
        Color col = Gizmos.color;
        Gizmos.color = Color.magenta;
        Vector3 pos = transform.position;
        Vector3 target = new Vector3(pos.x, pos.y - 10f, pos.z + 6f);
        // Gizmos.DrawRay(pos, target);
        Gizmos.DrawLine(pos, target);
    }
}
