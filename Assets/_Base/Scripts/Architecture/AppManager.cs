using UnityEngine;
using DG.Tweening;

namespace Architecture
{
    public class AppManager : BaseManager<AppManager>
    {
        protected override void OnAwake()
        {
            DOTween.Init();
        }
    }
}
