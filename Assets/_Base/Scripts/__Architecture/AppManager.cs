using System;
using System.Collections;
using UnityEngine;
using DG.Tweening;

using Pleiades.Architecture;

namespace Pleiades.__Architecture
{
    [Manageable]
    public class AppManager : BaseManager<AppManager>
    {
        public bool AllowAnyKey = true;

        private void OnAnyKeyPressed()
        {
            Debug.Log("Any Key Was Pressed!");
        }
        
        private void Start()
        {
            DOTween.Init();
            GUIManager.Instance.SetSceneGUI(Scenes.ROOT);
            ConfigLoader.Instance.LoadSceneConfig(Scenes.ROOT);
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
