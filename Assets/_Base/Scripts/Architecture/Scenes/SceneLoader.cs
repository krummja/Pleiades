using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using Sirenix.OdinInspector;

namespace Architecture
{
    using SakuraUI;
    using SakuraUI.Effectors;

    /// <summary>
    /// Enum corresponding to the scenes configured in Unity's Build Settings.
    ///
    /// Note that the order of the members of this enum must match the order of
    /// the scenes in Build Settings.
    /// </summary>
    public enum Scenes
    {
        ROOT,
        LOAD,
        PLEIADES_MAIN,
    }

    public class SceneLoader : SerializedBaseManager<SceneLoader>
    {
        /// <summary>
        /// Load the specified scene using the provided scene mode.
        /// </summary>
        /// <param name="scene">A Scenes enum member</param>
        /// <param name="mode">A LoadSceneMode enum member</param>
        /// <param name="async">Loads the scene asynchronously if true</param>
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

        /// <summary>
        /// Unload the specified scene.
        /// </summary>
        /// <param name="scene">A Scenes enum member</param>
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
