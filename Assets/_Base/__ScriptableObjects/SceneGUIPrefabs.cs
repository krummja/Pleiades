using System.Collections.Generic;
using UnityEngine;
using Sirenix.OdinInspector;

using Pleiades.__Architecture;

[CreateAssetMenu(menuName = "Scenes/GUIPrefabs", fileName = "SceneGUIPrefabs")]
public class SceneGUIPrefabs : SerializedScriptableObject
{
    public Dictionary<Scenes, GameObject> GUIPrefabs = new Dictionary<Scenes, GameObject>();
}
