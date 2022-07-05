using System;
using System.Collections;
using UnityEngine;
using DG.Tweening;

namespace Architecture
{
    using SakuraUI;

    public class AppManager : BaseManager<AppManager>
    {
        public bool AllowAnyKey = true;

        private void Start()
        {
            DOTween.Init();
            GUIManager.Instance.SetSceneGUI(Scenes.ROOT);
        }

        private void Update()
        {
            if ( AllowAnyKey && Input.anyKeyDown )
            {
                AllowAnyKey = false;
                SceneLoader.Instance.LoadScene(Scenes.PLEIADES_MAIN, async: true);
            }
        }
    }
}
