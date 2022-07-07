using System.Collections;
using System.Collections.Generic;
using Cinemachine;
using UnityEngine;
using Sirenix.OdinInspector;
using Pleiades.__Architecture;

public sealed class SA_Root : SceneArgs
{
}

[SceneControllerAttribute("Load")]
public sealed class SC_Root : SceneController<SC_Root, SA_Root>
{
    [BoxGroup("Scene Configuration")] 
    public SceneConfig Config;
}