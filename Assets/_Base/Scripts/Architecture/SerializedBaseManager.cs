using UnityEngine;
using Sirenix.OdinInspector;

namespace Architecture
{
    public class SerializedBaseManager<T> : SerializedMonoBehaviour where T : Component
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