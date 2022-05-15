using System.Collections;
using System.Collections.Generic;
using Architecture;
using UnityEngine;
using Sirenix.OdinInspector;

public sealed class SampleSceneArgs : SceneArgs
{
    public string SomeProperty;

    public void SomeInitializer()
    {
        Debug.Log(SomeProperty);
    }
}

[SceneControllerAttribute("SampleScene")]
public sealed class SampleSceneController : SceneController<SampleSceneController, SampleSceneArgs>
{
    [BoxGroup("Scene Configuration")]
    public SceneConfig Config;

    [BoxGroup("Scene Configuration")]
    public string SomeProperty;

    private bool isRunning_B = false;

    protected override void OnAwake()
    {
        Debug.Log(Config);
        Args.SomeProperty = SomeProperty;
        Args.SomeInitializer();
    }

    private void Start()
    {
        StartCoroutine(TestRoutine_A());
    }

    private IEnumerator TestRoutine_A()
    {
        Debug.Log("TestRoutine_A Started");
        Coroutine embedded = StartCoroutine(TestRoutine_B());
        yield return new WaitUntil(() => !isRunning_B);
        Debug.Log("TestRoutine_A Ended");
    }

    private IEnumerator TestRoutine_B()
    {
        Debug.Log("TestRoutine_B Started");
        isRunning_B = true;
        yield return new WaitForSeconds(3);
        isRunning_B = false;
        Debug.Log("TestRoutine_B Ended");
    }
}

