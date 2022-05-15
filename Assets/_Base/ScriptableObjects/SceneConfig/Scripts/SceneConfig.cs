using Architecture;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;
using Sirenix.OdinInspector;


[CreateAssetMenu(menuName = "Scenes/SceneConfig", fileName = "SceneConfig")]
public class SceneConfig : SerializedScriptableObject
{
    [BoxGroup("Information")]
    public Scenes Scene;

    [BoxGroup("Information")]
    [Multiline(4)]
    public string SceneDescription;

    [BoxGroup("Sounds")]
    public AudioClip SceneMusic;

    [BoxGroup("Sounds")]
    [Range(0.0f, 1.0f)]
    public float MusicVolume;

    [BoxGroup("Visuals")]
    public PostProcessProfile PostProcessProfile;
}
