using UnityEngine;

namespace Dev.Player
{
    public class PlayerHealth : MonoBehaviour
    {
        private Player player;

        public void HealthChanged()
        {
            if ( player.CurrentHealth.Value <= 0 )
                Destroy(gameObject);
        }

        private void Awake()
        {
            player = GetComponent<Player>();
        }
    }
}
