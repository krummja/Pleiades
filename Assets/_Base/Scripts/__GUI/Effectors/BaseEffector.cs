using UnityEngine;
using DG.Tweening;
using Sirenix.OdinInspector;

namespace Pleiades.__Architecture
{
    public class BaseEffector : MonoBehaviour
    {
        public bool IsComplete = false;

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
