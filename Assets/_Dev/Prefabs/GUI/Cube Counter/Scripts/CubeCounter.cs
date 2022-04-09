using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
using ScriptableObjectArchitecture;

namespace Dev.GUI
{
    public class CubeCounter : MonoBehaviour
    {
        public TextMeshProUGUI TextField;
        public GameObjectCollection Collection;

        private void Update()
        {
            TextField.text = $"There are {Collection.Count} Cubes!";
        }
    }
}
