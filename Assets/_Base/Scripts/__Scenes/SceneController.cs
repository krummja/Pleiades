using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Pleiades.__Architecture
{
    /// <summary>
    /// Scene Controller which handles scene transitioning and initialization
    /// of arguments.
    /// </summary>
    /// <typeparam name="TC">The class inheriting this SceneController</typeparam>
    /// <typeparam name="TA">A SceneArgs subclass with a parameterless constructor</typeparam>
    public abstract class SceneController<TC, TA> : MonoBehaviour
        where TC : SceneController<TC, TA>
        where TA : SceneArgs, new()
    {
        /// <summary>
        /// The SceneArgs instance that is bound to this controller.
        /// Consume attributes defined on the class inheriting from SceneArgs
        /// inside the OnAwake method.  
        /// </summary>
        public TA Args { get; private set; }

        /// <summary>
        /// Replacement for the typical Unity Awake method.
        ///
        /// This gets called when Unity's Awake method is called.
        /// </summary>
        protected virtual void OnAwake() {}
        
        /// <summary>
        /// Unity Awake event method. DO NOT OVERRIDE. Use the protected
        /// virtual method OnAwake instead.
        ///
        /// Uses the SceneHandler to saturate the Args property with the
        /// arguments defined in this scene's SceneArgs object.
        /// </summary>
        private void Awake()
        {
            Args = SceneHandler.GetArgs<TC, TA>();
            OnAwake();
        }
    }
}
