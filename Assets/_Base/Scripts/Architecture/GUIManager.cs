using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Pleiades.Architecture
{
    public class GUIManager : SerializedBaseManager<GUIManager>
    {
        public Dictionary<SceneIndex, GameObject> SceneGUIPrefabs = new Dictionary<SceneIndex, GameObject>();
        
        public GameObject ActiveGUI { get; private set; }
        
        public void SetSceneGUI(SceneIndex scene)
        {
            if (ActiveGUI)
                Destroy(ActiveGUI);

            GameObject guiPrefab = SceneGUIPrefabs[scene];
            ActiveGUI = Instantiate(guiPrefab);
            ActiveGUI.transform.parent = transform;
        }
    }
}
