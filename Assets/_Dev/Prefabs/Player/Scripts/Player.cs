using UnityEngine;
using ScriptableObjectArchitecture;
using Sirenix.OdinInspector;

namespace Dev.Player
{
    public class Player : MonoBehaviour
    {
        [Title("Health")]
        public FloatReference CurrentHealth;
        public FloatReference MaxHealth;

        private void Awake()
        {
            CurrentHealth.Value = MaxHealth.Value;
        }
    }
}
