using UnityEngine;


namespace Pleiades.__Architecture
{
    public class MainMenuCameraController : MonoBehaviour
    {
        public Vector3 Speed;
        
        private Transform camera;

        private void Start()
        {
            camera = CameraManager.Instance.MenuCamera.transform;
        }

        private void Update()
        {
            camera.position += Time.deltaTime * Speed;
        }
    }
}
