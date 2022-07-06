using System.Collections;
using System.Collections.Generic;
using Architecture;
using Cinemachine;
using UnityEngine;
using Sirenix.OdinInspector;

public sealed class SA_Root : SceneArgs
{
}

[SceneControllerAttribute("Load")]
public sealed class SC_Root : SceneController<SC_Root, SA_Root>
{
    [BoxGroup("Scene Configuration")] 
    public SceneConfig Config;
}