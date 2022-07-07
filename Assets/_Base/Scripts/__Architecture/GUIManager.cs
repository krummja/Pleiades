using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Pleiades.__Architecture
{
    [Manageable]
    public class GUIManager : SerializedBaseManager<GUIManager>
    {
        public Dictionary<Scenes, GameObject> SceneGUIPrefabs = new Dictionary<Scenes, GameObject>();
        
        public GameObject ActiveGUI { get; private set; }
        
        public void SetSceneGUI(Scenes scene)
        {
            if (ActiveGUI)
                Destroy(ActiveGUI);

            GameObject guiPrefab = SceneGUIPrefabs[scene];
            ActiveGUI = Instantiate(guiPrefab);
            ActiveGUI.transform.parent = transform;
        }
    }
}
