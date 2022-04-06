using UnityEngine;
using DG.Tweening;
using Sirenix.OdinInspector;

namespace GUI.Effectors
{
    public class BaseEffector : MonoBehaviour
    {
        [BoxGroup("Easing Settings")]
        public Ease EaseIn;

        [BoxGroup("Easing Settings")]
        public Ease EaseOut;
    }
}
