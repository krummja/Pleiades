using System.Collections;
using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
using Sirenix.OdinInspector;

namespace Pleiades.__Architecture
{
    public enum FadeType
    {
        FADE_IN,
        FADE_OUT,
        FADE_IN_OUT
    }

    public class FadeEffector : BaseEffector
    {
        [FoldoutGroup("Fade Settings")]
        public FadeType FadeType;

        [FoldoutGroup("Fade Settings")]
        public float Duration = 1f;

        private Image fadeImage;
        private Tween tween;

        public void Transition(FadeType fadeType)
        {
            FadeType = fadeType;
            Play();
        }

        public override void Play()
        {
            fadeImage = GetComponent<Image>();
            IsComplete = false;

            switch ( FadeType )
            {
                case FadeType.FADE_IN:
                {
                    fadeImage.color = new Color(0, 0, 0, 0);
                    StartCoroutine(FadeIn());
                    // tween.OnComplete(() => IsComplete = !tween.active);
                    break;
                }

                case FadeType.FADE_OUT:
                {
                    fadeImage.color = new Color(0, 0, 0, 1);
                    StartCoroutine(FadeOut());
                    tween.OnComplete(() => IsComplete = !tween.active);
                    break;
                }

                case FadeType.FADE_IN_OUT:
                {
                    fadeImage.color = new Color(0, 0, 0, 0);
                    StartCoroutine(FadeIn());
                    tween.OnComplete(() => StartCoroutine(FadeOut()));
                    // tween.OnComplete(() => IsComplete = !tween.active);
                    break;
                }
            }
        }

        public override void Kill()
        {
            tween.Kill();
        }

        private IEnumerator FadeIn()
        {
            tween = fadeImage.DOFade(1.0f, Duration);
            tween.SetEase(this.EaseIn);
            while ( tween.active )
                yield return null;
        }

        private IEnumerator FadeOut()
        {
            tween = fadeImage.DOFade(0.0f, Duration);
            tween.SetEase(this.EaseOut);
            while ( tween.active )
                yield return null;
        }
    }
}
