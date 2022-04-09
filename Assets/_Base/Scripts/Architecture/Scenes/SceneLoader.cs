using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using Sirenix.OdinInspector;

namespace Architecture
{
    public enum Scenes
    {
        BOOT,
        LOAD,
        UI,
        SAMPLE
    }

    /// <summary>
    /// Basic facade for Unity's SceneManager.
    ///
    /// Allows for scene access by Scenes enum, corresponding to the
    /// order of scenes specified in Build Settings.
    /// </summary>
    public class SceneLoader : SerializedBaseManager<SceneLoader>
    {
        #region FIELDS

        public Dictionary<Scenes, GameScene> SceneConfig = new Dictionary<Scenes, GameScene>();

        private float targetLoadValue;

        #endregion


        #region DELEGATES

        public delegate void SceneLoaderAction();

        #endregion


        #region EVENTS

        public static event SceneLoaderAction OnSceneConfigLoaded;

        public static event SceneLoaderAction OnSceneLoadStart;

        public static event SceneLoaderAction OnSceneLoadEnd;

        public static event SceneLoaderAction OnSceneUnloaded;

        #endregion


        #region PROPERTIES

        public AsyncOperation CurrentOperation { get; private set; }
        public float LoadProgress { get; private set; }
        public Scene ActiveScene { get; private set; }

        #endregion


        #region PUBLIC METHODS

        public void LoadScene(Scenes scene, LoadSceneMode mode = LoadSceneMode.Additive)
        {
            UnityEngine.SceneManagement.SceneManager.LoadScene((int) scene, mode);
        }

        public void UnloadScene(Scenes scene)
        {
            StartCoroutine(UnloadSceneAsync(scene));
        }

        public void LoadSceneAsync(Scenes scene, LoadSceneMode mode = LoadSceneMode.Additive)
        {
            // Notify that scene loading has started.
            if ( OnSceneLoadStart != null )
                OnSceneLoadStart();

            // Bring in the LOAD scene.
            UnityEngine.SceneManagement.SceneManager.LoadScene((int) Scenes.LOAD, LoadSceneMode.Additive);

            // Load any GameConfig for the scene.
            LoadSceneConfig(scene);

            // Start the actual scene loading coroutine.
            StartCoroutine(SceneLoadRoutine(scene, mode));
        }

        public IEnumerator UnloadSceneAsync(Scenes scene)
        {
            AsyncOperation operation = UnityEngine.SceneManagement.SceneManager.UnloadSceneAsync((int) scene);

            while ( !operation.isDone )
                yield return null;

            if ( OnSceneUnloaded != null )
                OnSceneUnloaded();
        }

        public bool IsSceneLoaded(Scenes scene)
        {
            return UnityEngine.SceneManagement.SceneManager.GetSceneByBuildIndex((int) scene).isLoaded;
        }

        #endregion


        #region PRIVATE METHODS

        protected override void OnAwake()
        {
            LoadProgress = targetLoadValue = 0;
        }

        private void LoadSceneConfig(Scenes scene)
        {
            if ( SceneConfig.ContainsKey(scene) )
            {
                GameScene config = SceneConfig[scene];
                AudioManager.Instance.LoadSceneAudio(config.SceneMusic, config.MusicVolume);
                CameraManager.Instance.LoadSceneCamera(config.CameraPrefab, config.PostProcessProfile);

                if ( OnSceneConfigLoaded != null )
                    OnSceneConfigLoaded();
            }
        }

        private IEnumerator SceneLoadRoutine(Scenes scene, LoadSceneMode mode = LoadSceneMode.Additive)
        {
            yield return null;

            AsyncOperation operation = UnityEngine.SceneManagement.SceneManager.LoadSceneAsync((int) scene, mode);
            operation.allowSceneActivation = false;

            while ( !operation.isDone )
            {
                LoadProgress = operation.progress * 100f;

                if ( LoadProgress >= 0.95f )
                {
                    StartCoroutine(UnloadSceneAsync(Scenes.LOAD));
                    ActiveScene = UnityEngine.SceneManagement.SceneManager.GetActiveScene();

                    if ( OnSceneLoadEnd != null )
                        OnSceneLoadEnd();

                    operation.allowSceneActivation = true;
                }

                yield return null;
            }
        }

        #endregion
    }
}
