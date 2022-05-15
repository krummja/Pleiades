using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Architecture
{
    using UnityEngine.SceneManagement;


    public static class SceneHandler
    {
        private static readonly Dictionary<Type, SceneArgs> args;

        static SceneHandler()
        {
            args = new Dictionary<Type, SceneArgs>();
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

        public static AsyncOperation OpenSceneWithArgs<TController, TArgs>(TArgs sceneArgs, bool additive)
            where TController : SceneController<TController, TArgs>
            where TArgs : SceneArgs, new()
        {
            Type type = typeof(TController);
            SceneControllerAttribute attribute = GetAttribute<SceneControllerAttribute>(type);

            if ( attribute == null ) {
                throw new NullReferenceException(
                    $"You're trying to load scene controller without {nameof(SceneControllerAttribute)}");
            }

            string sceneName = attribute.SceneName;

            args.Add(type, sceneArgs ?? new TArgs { IsNull = true });

            LoadSceneMode mode = additive ? LoadSceneMode.Additive : LoadSceneMode.Single;
            return UnityEngine.SceneManagement.SceneManager.LoadSceneAsync(sceneName, mode);
        }

        public static TArgs GetArgs<TController, TArgs>()
            where TController : SceneController<TController, TArgs>
            where TArgs : SceneArgs, new()
        {
            Type type = typeof(TController);
            if ( !args.ContainsKey(type) || args[type] == null ) {
                return new TArgs { IsNull = true };
            }

            TArgs sceneArgs = (TArgs) args[type];
            args.Remove(type);
            return sceneArgs;
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
