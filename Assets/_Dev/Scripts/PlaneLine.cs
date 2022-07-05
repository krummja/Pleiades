using UnityEngine;

public class PlaneLine : MonoBehaviour
{
    public Transform PointA;
    public Transform PointB;

    private LineRenderer renderer;
    
    private void Awake()
    {
        renderer = GetComponent<LineRenderer>();
    }

    private void Update()
    {
        renderer.SetPosition(0, PointA.position);
        renderer.SetPosition(1, PointB.position);
    }
}
