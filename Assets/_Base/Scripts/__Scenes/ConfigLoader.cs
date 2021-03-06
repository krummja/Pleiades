using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Pleiades.__Architecture
{
    public class ConfigLoader : SerializedBaseManager<ConfigLoader>
    {
        public Dictionary<Scenes, SceneConfig> SceneConfigs = new Dictionary<Scenes, SceneConfig>();

        public delegate void ConfigLoaderAction();

        public static event ConfigLoaderAction OnConfigLoadStart;
        public static event ConfigLoaderAction OnConfigLoadEnd;

        public void LoadSceneConfig(Scenes scene)
        {
            if ( SceneConfigs.ContainsKey(scene) )
            {
                OnConfigLoadStart?.Invoke();

                SceneConfig config = SceneConfigs[scene];
                AudioManager.Instance.LoadSceneAudio(config.SceneMusic, config.MusicVolume);
                CameraManager.Instance.LoadSceneCamera(config.Camera, config.PostProcessProfile);
                
                OnConfigLoadEnd?.Invoke();
            }
        }
    }
}
