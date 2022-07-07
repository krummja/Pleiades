using Sirenix.OdinInspector.Editor;
using System;
using System.Linq;
using UnityEditor;

namespace Pleiades.__Architecture
{
    public class ManagerEditor : OdinEditorWindow
    {
        private static Type[] typesToDisplay = TypeCache.GetTypesWithAttribute<ManageableAttribute>()
            .OrderBy(m => m.Name)
            .ToArray();

        private Type selectedType;

        [MenuItem("Pleiades/Managers")]
        private static void OpenEditor() => GetWindow<ManagerEditor>();

        protected override void OnGUI()
        {
            GUIUtils.SelectButtonList(ref selectedType, typesToDisplay);
            base.OnGUI();
        }

        protected override object GetTarget()
        {
            if (selectedType == null && typesToDisplay.Length > 0)
                selectedType = typesToDisplay[0];

            if (selectedType == null)
                return null;
            else
                return FindObjectOfType(selectedType);
        }
    }
}

