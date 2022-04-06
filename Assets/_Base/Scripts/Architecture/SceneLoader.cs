using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace Architecture
{
    public enum Scenes
    {
        BOOT,
        UI
    }

    public class SceneLoader : BaseManager<SceneLoader>
    {
        public void LoadSceneAsync(Scenes scene)
        {
            SceneManager.LoadSceneAsync((int) scene, LoadSceneMode.Additive);
        }

        public void UnloadSceneAsync(Scenes scene)
        {
            SceneManager.UnloadSceneAsync((int) scene);
        }

        public bool IsSceneLoaded(Scenes scene)
        {
            return SceneManager.GetSceneByBuildIndex((int) scene).isLoaded;
        }
    }
}
