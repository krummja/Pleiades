using UnityEngine;
using Sirenix.OdinInspector;
using Sirenix.OdinInspector.Editor;
using UnityEditor;
using System;

namespace Pleiades.__Architecture
{
    public class GameEditor : OdinMenuEditorWindow
    {
        protected override OdinMenuTree BuildMenuTree()
        {
            OdinMenuTree tree = new OdinMenuTree();
            tree.Selection.SupportsMultiSelect = false;
            return tree;
        }
        
        [MenuItem("Pleiades/GameEditor")]
        private static void OpenWindow()
        {
            GetWindow<GameEditor>().Show();
        }
    }
}
