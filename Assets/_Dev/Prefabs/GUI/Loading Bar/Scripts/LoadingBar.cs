using UnityEngine;
using UnityEngine.UI;

namespace Dev.GUI
{
    using Architecture;

    public class LoadingBar : MonoBehaviour
    {
        public Image ProgressBar;

        private void Start()
        {
            ProgressBar.fillAmount = 0;
        }

        private void Update()
        {
            ProgressBar.fillAmount = SceneLoader.Instance.LoadProgress;
        }
    }
}
