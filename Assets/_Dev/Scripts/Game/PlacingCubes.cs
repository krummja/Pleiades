using System.Collections;
using System.Collections.Generic;
using UnityEngine;


namespace Game
{
    using Dev.Cube;

    public class PlacingCubes : MonoBehaviour
    {
        public GameObject CubePrefab;
        public Camera Camera;

        private void Update()
        {
            if ( Input.GetKeyDown(KeyCode.Mouse0) )
                PlaceCube();
            if ( Input.GetKeyDown(KeyCode.Mouse1) )
                DeleteCube();
        }

        private void PlaceCube()
        {
            Vector3 mousePosInWorld = GetMousePositionInWorld();
            GameObject cube = SpawnCubeInWorld(mousePosInWorld);
        }

        private void DeleteCube()
        {
            RaycastHit hit = new RaycastHit();
            if ( Physics.Raycast(GetMouseRay(), out hit) )
                Destroy(hit.collider.gameObject);
        }

        private Ray GetMouseRay()
        {
            Vector3 mousePos = Input.mousePosition;
            mousePos.z = Camera.nearClipPlane;
            return Camera.ScreenPointToRay(mousePos);
        }

        private Vector3 GetMousePositionInWorld()
        {
            Vector3 mousePos = Input.mousePosition;
            mousePos.z = Camera.nearClipPlane;
            Vector3 mouseWorldPos = Camera.ScreenToWorldPoint(mousePos);
            mouseWorldPos.z = 0;
            return mouseWorldPos;
        }

        private GameObject SpawnCubeInWorld(Vector3 position)
        {
            GameObject cube = GameObject.Instantiate(CubePrefab);
            cube.transform.position = position;
            return cube;
        }
    }
}
