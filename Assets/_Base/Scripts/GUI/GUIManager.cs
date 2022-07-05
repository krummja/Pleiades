using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace SakuraUI
{
    using Architecture;

    public class GUIManager : BaseManager<GUIManager>
    {
        // public Dictionary<Scenes, GameObject> SceneGUIPrefabs = new Dictionary<Scenes, GameObject>();
        public SceneGUIPrefabs SceneGUIPrefabs;
        
        private Dictionary<Scenes, GameObject> sceneGUIPrefabs;
        
        public GameObject ActiveGUI { get; private set; }
        
        public void SetSceneGUI(Scenes scene)
        {
            if (ActiveGUI)
                Destroy(ActiveGUI);

            GameObject guiPrefab = sceneGUIPrefabs[scene];
            ActiveGUI = Instantiate(guiPrefab);
            ActiveGUI.transform.parent = transform;
        }
        
        protected override void OnAwake()
        {
            this.sceneGUIPrefabs = SceneGUIPrefabs.GUIPrefabs;
        }
    }
}
