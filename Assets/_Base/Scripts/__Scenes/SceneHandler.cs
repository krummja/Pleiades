using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Pleiades.__Architecture
{
    using UnityEngine.SceneManagement;
    
    public static class SceneHandler
    {
        private static readonly Dictionary<Type, SceneArgs> args;

        static SceneHandler()
        {
            args = new Dictionary<Type, SceneArgs>();
        }

        /// <summary>
        /// Open a scene with the SceneArgs object passed as scene arguments.
        /// </summary>
        /// <param name="sceneArgs">The instance of the class inheriting from SceneArgs</param>
        /// <param name="additive">Whether to load additively or not</param>
        /// <typeparam name="TC">A class inheriting from SceneController</typeparam>
        /// <typeparam name="TA">A class inheriting from SceneArgs</typeparam>
        /// <returns>
        /// Invocation to UnityEngine's LoadSceneAsync applied to the scene name and
        /// additive selection
        /// </returns>
        /// <exception cref="NullReferenceException">
        /// Thrown in the case that the handler attempts to open a scene whose SceneController lacks
        /// a SceneControllerAttribute to bind the scene name to the controller
        /// </exception>
        public static AsyncOperation OpenSceneWithArgs<TC, TA>(TA sceneArgs, bool additive)
            where TC : SceneController<TC, TA>
            where TA : SceneArgs, new()
        {
            Type type = typeof(TC);
            SceneControllerAttribute attribute = GetAttribute<SceneControllerAttribute>(type);

            if ( attribute == null ) {
                throw new NullReferenceException(
                    $"You're trying to load scene controller without {nameof(SceneControllerAttribute)}");
            }

            string sceneName = attribute.SceneName;

            args.Add(type, sceneArgs ?? new TA { IsNull = true });

            LoadSceneMode mode = additive ? LoadSceneMode.Additive : LoadSceneMode.Single;
            return UnityEngine.SceneManagement.SceneManager.LoadSceneAsync(sceneName, mode);
        }

        /// <summary>
        /// Get the arguments defined in the class inheriting from SceneArgs 
        /// </summary>
        /// <typeparam name="TC">A class inheriting from SceneController</typeparam>
        /// <typeparam name="TA">A class inheriting from SceneArgs</typeparam>
        /// <returns>
        /// The SceneArgs referenced or a newly created SceneArgs instance with
        /// a true IsNull attribute
        /// </returns>
        public static TA GetArgs<TC, TA>()
            where TC : SceneController<TC, TA>
            where TA : SceneArgs, new()
        {
            Type type = typeof(TC);
            if ( !args.ContainsKey(type) || args[type] == null ) {
                return new TA { IsNull = true };
            }

            TA sceneArgs = (TA) args[type];
            args.Remove(type);
            return sceneArgs;
        }
        
        private static T GetAttribute<T>(Type type) where T : Attribute
        {
            object[] attributes = type.GetCustomAttributes(true);
            foreach ( object attribute in attributes ) {
                if ( attribute is T targetAttribute ) {
                    return targetAttribute;
                }
            }

            return null;
        }
    }


    public abstract class SceneArgs
    {
        public bool IsNull { get; set; }
    }


    [AttributeUsage(AttributeTargets.Class)]
    public sealed class SceneControllerAttribute : Attribute
    {
        public string SceneName { get; private set; }

        public SceneControllerAttribute(string name)
        {
            SceneName = name;
        }
    }
}
