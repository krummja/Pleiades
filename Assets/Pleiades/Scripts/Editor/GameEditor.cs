using UnityEngine;
using Sirenix.OdinInspector;
using Sirenix.OdinInspector.Editor;
using UnityEditor;


namespace Pleiades.Editor
{
    public class GameEditor : OdinEditorWindow
    {
        [MenuItem("Pleiades/GameEditor")]
        private static void OpenWindow()
        {
            GetWindow<GameEditor>().Show();
        }

        public string Hello;
    }
}

