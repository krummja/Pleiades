using UnityEngine;


[CreateAssetMenu(menuName = "Scenes/GameScene", fileName = "GameScene")]
public class GameScene : ScriptableObject
{
    [Header("Information")]
    public string SceneName;
    public string SceneDescription;
}
