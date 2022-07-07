using System.Collections;
using System.Collections.Generic;
using Cinemachine;
using UnityEngine;
using Sirenix.OdinInspector;
using Pleiades.__Architecture;

public sealed class SA_Load : SceneArgs
{
}

[SceneControllerAttribute("Load")]
public sealed class SC_Load : SceneController<SC_Load, SA_Load>
{
    [BoxGroup("Scene Configuration")] 
    public SceneConfig Config;
}