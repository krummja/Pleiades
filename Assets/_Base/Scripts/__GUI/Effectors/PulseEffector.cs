using System.Collections;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
using Sirenix.OdinInspector;

namespace Pleiades.__Architecture
{
    /// <summary>
    /// UI Element Effector - Pulse
    ///
    /// Causes the UI element to pulse gently.
    /// Connect method `Kill` in inspector where needed.
    /// </summary>
    public class PulseEffector : BaseEffector
    {
        [FoldoutGroup("Pulse Settings")]
        public float Scale = 2f;

        [FoldoutGroup("Pulse Settings")]
        public float Duration = 1f;

        private Tween grow;
        private Tween shrink;

        public override void Kill()
        {
            grow.Kill();
            shrink.Kill();
            transform.localScale = Vector3.one;
        }

        private void Start()
        {
            StartCoroutine(PulseGrow());
        }

        private IEnumerator PulseGrow()
        {
            grow = transform.DOScale(Scale, Duration);
            grow.SetEase(this.EaseIn);
            grow.OnComplete(() => StartCoroutine(PulseShrink()));
            while ( !grow.playedOnce )
                yield return grow;
        }

        private IEnumerator PulseShrink()
        {
            shrink = transform.DOScale(1f, Duration);
            shrink.SetEase(this.EaseOut);
            shrink.OnComplete(() => StartCoroutine(PulseGrow()));
            while ( !shrink.playedOnce )
                yield return shrink;
        }
    }
}
