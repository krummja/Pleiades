using System.Collections.Generic;
using Architecture;
using UnityEngine;
using Sirenix.OdinInspector;


[CreateAssetMenu(menuName = "Scenes/GUIPrefabs", fileName = "SceneGUIPrefabs")]
public class SceneGUIPrefabs : SerializedScriptableObject
{
    public Dictionary<Scenes, GameObject> GUIPrefabs = new Dictionary<Scenes, GameObject>();
}
