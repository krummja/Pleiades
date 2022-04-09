using UnityEngine;
using UnityEngine.UI;
using Sirenix.OdinInspector;

namespace GUI
{
    using Architecture;

    public class GUIManager : BaseManager<GUIManager>
    {
        [FoldoutGroup("Canvas Layers")]
        public Canvas BackgroundLayer;

        [FoldoutGroup("Canvas Layers")]
        public Canvas RootLayer;

        [FoldoutGroup("Canvas Layers")]
        public Canvas ForegroundLayer;
    }
}
