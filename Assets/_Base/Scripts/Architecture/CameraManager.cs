using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;
using UnityEngine.SceneManagement;

namespace Architecture
{
    public class CameraManager : BaseManager<CameraManager>
    {
        public GameObject MainCamera;
        public GameObject MenuCamera;
        
        private PostProcessProfile postProcessProfile;

        public GameObject ActiveCamera { get; private set; }
        
        public void LoadSceneCamera(CameraType camera, PostProcessProfile profile)
        {
            if (ActiveCamera)
            {
                Debug.Log("Active camera found");
                ActiveCamera.SetActive(false);
            }

            switch (camera)
            {
                case CameraType.MAIN:
                {
                    ActiveCamera = MainCamera;
                    break;
                }
                
                case CameraType.MENU:
                {
                    ActiveCamera = MenuCamera;
                    break;
                }
            }
            
            ActiveCamera.SetActive(true);
            
            postProcessProfile = profile;
            PostProcessVolume volume = ActiveCamera.GetComponent<PostProcessVolume>();
            volume.profile = postProcessProfile;
        }

        protected override void OnAwake()
        {
            ActiveCamera = MenuCamera;
        }
    }
}
