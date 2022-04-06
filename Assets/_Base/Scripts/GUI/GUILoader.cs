using UnityEngine;
using Architecture;

namespace GUI
{
    public class GUILoader : MonoBehaviour
    {
        private void Update()
        {
            if ( Input.GetKeyDown(KeyCode.F1) )
            {
                if ( !SceneLoader.Instance.IsSceneLoaded(Scenes.UI) )
                    SceneLoader.Instance.LoadSceneAsync(Scenes.UI);
                else
                    SceneLoader.Instance.UnloadSceneAsync(Scenes.UI);
            }
        }
    }
}
