using UnityEngine;


public class PlanetLineController : MonoBehaviour
{
    private Transform anchor;
    private float planeDistance;
    private LineRenderer renderer;

    private void Awake()
    {
        GameObject anchorObj = new GameObject();
        this.anchor = anchorObj.transform;
        this.anchor.parent = transform;

        renderer = GetComponent<LineRenderer>();
        renderer.positionCount = 2;
    }

    private void Update()
    {
        Transform controller = GameObject.Find("ViewController").transform;
        this.planeDistance = controller.position.y - transform.position.y;
        Vector3 newPos = new Vector3(
            transform.position.x,
            this.planeDistance + transform.position.y,
            transform.position.z
        );
        this.anchor.position = newPos;
        
        renderer.SetPosition(0, anchor.position);
        renderer.SetPosition(1, transform.position);
    }
}
