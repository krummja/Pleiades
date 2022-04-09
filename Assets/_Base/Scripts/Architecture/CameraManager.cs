using UnityEngine;
using UnityEngine.Rendering.PostProcessing;
using UnityEngine.SceneManagement;

namespace Architecture
{
    public class CameraManager : BaseManager<CameraManager>
    {
        public Camera Camera;

        private GameObject cameraPrefab;

        private PostProcessProfile postProcessProfile;

        public void LoadSceneCamera(GameObject sceneCamera, PostProcessProfile profile)
        {
            cameraPrefab = sceneCamera;
            Camera = sceneCamera.GetComponent<Camera>();
            postProcessProfile = profile;
        }

        private void PlaceCamera()
        {
            GameObject cameraObj = Instantiate(cameraPrefab);
            Scene activeScene = SceneLoader.Instance.ActiveScene;
            PostProcessVolume volume = cameraObj.GetComponent<PostProcessVolume>();
            volume.profile = postProcessProfile;
            UnityEngine.SceneManagement.SceneManager.MoveGameObjectToScene(cameraObj, activeScene);
        }

        private void OnEnable()
        {
            SceneLoader.OnSceneLoadEnd += PlaceCamera;
        }

        private void OnDisable()
        {
            SceneLoader.OnSceneLoadEnd -= PlaceCamera;
        }
    }
}
