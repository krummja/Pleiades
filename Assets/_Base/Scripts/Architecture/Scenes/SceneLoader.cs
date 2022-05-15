using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using Sirenix.OdinInspector;

namespace Architecture
{
    using SakuraUI;
    using SakuraUI.Effectors;

    public enum Scenes
    {
        ROOT,
        LOAD,
        SAMPLE_1,
        SAMPLE_2,
    }

    public class SceneLoader : SerializedBaseManager<SceneLoader>
    {
        public void LoadScene(Scenes scene, LoadSceneMode mode = LoadSceneMode.Additive, bool async = false)
        {
            ConfigLoader.Instance.LoadSceneConfig(scene);
            if ( async )
            {
                SceneManager.LoadScene((int) Scenes.LOAD, LoadSceneMode.Additive);
                StartCoroutine(LoadSceneAsync(scene, mode));
            }
            else
            {
                SceneManager.LoadScene((int) scene, mode);
            }
        }

        public void UnloadScene(Scenes scene)
        {
            StartCoroutine(UnloadSceneAsync(scene));
        }

        private IEnumerator LoadSceneAsync(Scenes scene, LoadSceneMode mode = LoadSceneMode.Additive)
        {
            yield return null;

            AsyncOperation operation = SceneManager.LoadSceneAsync((int) scene, mode);
            SmoothLoader.Instance.BeginLoadOperation(operation);
            GUIManager.Instance.SetSceneGUI(Scenes.LOAD);

            while ( !SmoothLoader.Instance.LoadComplete )
                yield return null;

            if ( SmoothLoader.Instance.LoadComplete )
            {
                StartCoroutine(UnloadSceneAsync(Scenes.LOAD));
                GUIManager.Instance.SetSceneGUI(scene);
            }
        }

        private IEnumerator UnloadSceneAsync(Scenes scene)
        {
            yield return null;
            AsyncOperation operation = SceneManager.UnloadSceneAsync((int) scene);

            while ( !operation.isDone )
                yield return null;
        }
    }
}
