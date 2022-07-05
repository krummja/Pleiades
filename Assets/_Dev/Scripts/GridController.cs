using UnityEngine;
using Sirenix.OdinInspector;

public class GridController : MonoBehaviour
{
    [BoxGroup("GameObject References")]
    public Transform Target;
    
    [BoxGroup("Grid Settings")]
    [Range(0.01f, 10f)]
    public float Snap;

    private float distanceToTarget;

    private void Awake()
    {
        this.distanceToTarget = Vector3.Distance(transform.position, Target.position);
    }
    
    private void Update()
    {
        if (Snap < 0.01f) Snap = 0.01f;
        
        Vector3 pos = new Vector3(
            Mathf.Round(Target.position.x / Snap) * Snap,
            this.Target.position.y - this.distanceToTarget,
            Mathf.Round(Target.position.z / Snap) * Snap
        );
        transform.position = pos;
    }
}
