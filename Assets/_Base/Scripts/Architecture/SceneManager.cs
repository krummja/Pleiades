using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Sirenix.OdinInspector;
using UnityEngine.SceneManagement;
using USM = UnityEngine.SceneManagement.SceneManager;


namespace Pleiades.Architecture
{
    public enum SceneIndex
    {
        ROOT,
        LOAD,
        MAIN,
    }
    
    public class SceneManager : BaseManager<SceneManager>
    {
        public void LoadScene(SceneIndex atIndex, LoadSceneMode mode = LoadSceneMode.Additive, bool async = false)
        {
            if (async)
            {
                USM.LoadScene((int) SceneIndex.LOAD, LoadSceneMode.Additive);
                StartCoroutine(LoadSceneAsync(atIndex, mode));
            }
            else
            {
                USM.LoadScene((int) atIndex, mode);
            }
        }

        public void UnloadScene(SceneIndex atIndex)
        {
            StartCoroutine(UnloadSceneAsync(atIndex));
        }

        private IEnumerator LoadSceneAsync(SceneIndex atIndex, LoadSceneMode mode = LoadSceneMode.Additive)
        {
            AsyncOperation loading = USM.LoadSceneAsync((int) atIndex, mode);
            SmoothLoader.Instance.BeginLoadOperation(loading);
            GUIManager.Instance.SetSceneGUI(SceneIndex.LOAD);

            while (!SmoothLoader.Instance.LoadComplete)
                yield return null;

            StartCoroutine(UnloadSceneAsync(SceneIndex.LOAD));
            GUIManager.Instance.SetSceneGUI(atIndex);
        }

        private IEnumerator UnloadSceneAsync(SceneIndex atIndex)
        {
            yield return null;
            AsyncOperation unloading = USM.UnloadSceneAsync((int) atIndex);
            while (!unloading.isDone)
                yield return null;
        }
    }
}
