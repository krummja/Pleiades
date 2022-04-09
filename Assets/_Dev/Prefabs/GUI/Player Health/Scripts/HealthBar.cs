using UnityEngine;
using UnityEngine.UI;
using ScriptableObjectArchitecture;

namespace Dev.GUI
{
    using Player;

    public class HealthBar : MonoBehaviour
    {
        public FloatReference Variable = default(FloatReference);
        public FloatReference MaxValue = default(FloatReference);
        public Image FillImage = default(Image);

        private void Update()
        {
            FillImage.fillAmount = Mathf.Clamp01(Variable.Value / MaxValue.Value);
        }
    }
}
