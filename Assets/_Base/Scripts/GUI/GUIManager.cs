using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace SakuraUI
{
    using Architecture;

    public class GUIManager : SerializedBaseManager<GUIManager>
    {
        public Dictionary<Scenes, GameObject> SceneGUIPrefabs = new Dictionary<Scenes, GameObject>();

        public GameObject ActiveGUI { get; private set; }

        public void SetSceneGUI(Scenes scene)
        {
            if (ActiveGUI != null)
                Destroy(ActiveGUI);

            GameObject guiPrefab = SceneGUIPrefabs[scene];
            ActiveGUI = Instantiate(guiPrefab);
            ActiveGUI.transform.parent = transform;
        }
    }
}
