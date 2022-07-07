using UnityEngine;
using UnityEngine.UI;
using Sirenix.OdinInspector;

namespace Pleiades.__Architecture
{
    public class LayerController : MonoBehaviour
    {
        [FoldoutGroup("Canvas Layers")]
        public Canvas BackgroundLayer;

        [FoldoutGroup("Canvas Layers")]
        public Canvas RootLayer;

        [FoldoutGroup("Canvas Layers")]
        public Canvas ForegroundLayer;
    }
}
