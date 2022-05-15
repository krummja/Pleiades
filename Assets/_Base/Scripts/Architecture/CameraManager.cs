using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;
using UnityEngine.SceneManagement;

namespace Architecture
{
    public class CameraManager : BaseManager<CameraManager>
    {
        public GameObject MainCamera;

        public PostProcessProfile PostProcessProfile;

        public void LoadSceneCamera(PostProcessProfile profile)
        {
            this.PostProcessProfile = profile;
            PostProcessVolume volume = MainCamera.GetComponent<PostProcessVolume>();
            volume.profile = this.PostProcessProfile;
        }
    }
}
