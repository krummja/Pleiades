using UnityEngine;
using DG.Tweening;
using Sirenix.OdinInspector;

namespace GUI.Effectors
{
    public class BaseEffector : MonoBehaviour
    {
        [FoldoutGroup("Easing Settings")]
        public Ease EaseIn;

        [FoldoutGroup("Easing Settings")]
        public Ease EaseOut;

        [Button]
        [FoldoutGroup("Debug")]
        [HorizontalGroup("Debug/Split")]
        [VerticalGroup("Debug/Split/Left")]
        public virtual void Play() {}

        [Button]
        [HorizontalGroup("Debug/Split")]
        [VerticalGroup("Debug/Split/Right")]
        public virtual void Kill() {}
    }
}
