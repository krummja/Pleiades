using UnityEngine;
using UnityEngine.UI;
using ScriptableObjectArchitecture;

namespace Dev.GUI
{
    using Architecture;

    public class LoadingBar : MonoBehaviour
    {
        public Image ProgressBar;

        public FloatVariable Progress;

        private void Start()
        {
            ProgressBar.fillAmount = 0;
        }

        private void Update()
        {
            ProgressBar.fillAmount = Progress.Value;
        }
    }
}
