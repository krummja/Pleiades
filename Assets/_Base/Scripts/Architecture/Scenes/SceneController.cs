using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Architecture
{
    public abstract class SceneController<TController, TArgs> : MonoBehaviour
        where TController : SceneController<TController, TArgs>
        where TArgs : SceneArgs, new()
    {
        protected TArgs Args { get; private set; }

        private void Awake()
        {
            Args = SceneHandler.GetArgs<TController, TArgs>();
            OnAwake();
        }

        protected virtual void OnAwake() {}
    }
}
