using UnityEngine;


namespace Runtime
{
    public class BaseManager<T> : MonoBehaviour where T : Component
    {
        public static T Instance { get; private set; }

        protected virtual void Awake()
        {
            if ( Instance == null )
            {
                Instance = this as T;
                DontDestroyOnLoad(this);
            }
            else
            {
                Destroy(gameObject);
            }

            OnAwake();
        }

        protected virtual void OnAwake() {}
    }
}
