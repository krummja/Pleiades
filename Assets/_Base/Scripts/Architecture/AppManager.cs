using System;
using System.Collections;
using UnityEngine;
using DG.Tweening;

namespace Architecture
{
    public class AppManager : BaseManager<AppManager>
    {
        public bool AllowAnyKey = true;

        protected override void OnAwake()
        {
            DOTween.Init();
        }

        private void Start()
        {
            if ( SceneLoader.Instance.IsSceneLoaded(Scenes.BOOT) )
                SceneLoader.Instance.UnloadScene(Scenes.BOOT);
            if ( !SceneLoader.Instance.IsSceneLoaded(Scenes.UI) )
                SceneLoader.Instance.LoadScene(Scenes.UI);
        }

        private void Update()
        {
            if ( AllowAnyKey && Input.anyKeyDown )
            {
                AllowAnyKey = false;
                SceneLoader.Instance.LoadSceneAsync(Scenes.SAMPLE);
            }
        }
    }
}
