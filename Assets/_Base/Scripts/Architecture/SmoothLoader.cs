using UnityEngine;
using ScriptableObjectArchitecture;

namespace Pleiades.Architecture
{
    public class SmoothLoader : BaseManager<SmoothLoader>
    {
        public FloatVariable Current;
        public float TargetValue;

        public bool LoadComplete { get; private set; }

        [Range(0, 1)]
        public float ProgressMultiplier = 0.25f;

        private AsyncOperation loadOperation;

        public void BeginLoadOperation(AsyncOperation operation)
        {
            Current.Value = 0f;
            LoadComplete = false;
            this.loadOperation = operation;
            this.loadOperation.allowSceneActivation = false;
        }

        private void Update()
        {
            if ( loadOperation != null )
            {
                TargetValue = loadOperation.progress / 0.9f;
                Current.Value = Mathf.MoveTowards(Current.Value, TargetValue, ProgressMultiplier * Time.deltaTime);

                if ( Current.Value >= 0.9f )
                {
                    LoadComplete = true;
                    loadOperation.allowSceneActivation = true;
                }
            }
        }
    }
}
