using System;
using System.Collections;
using UnityEngine;
using Sirenix.OdinInspector;

namespace Pleiades.Architecture
{
    public class InputManager : BaseManager<InputManager>
    {
        public bool AllowAnyKey = true;
        
        public static event Action OnAnyKeyPressed;

        private void Update()
        {
            if (AllowAnyKey && Input.anyKeyDown)
                OnAnyKeyPressed?.Invoke();
        }
    }
}
