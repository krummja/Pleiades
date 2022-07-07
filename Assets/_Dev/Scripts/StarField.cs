using UnityEngine;
using System.Collections;


namespace Pleiades
{
    public class StarField : MonoBehaviour
    {
        public int MaxStars = 100;
        public float StarSize = 1f;
        public float StarDistance = 10f;
        public float StarClipDistance = 1f;

        private Transform _transform;
        private float starDistanceSqr;
        private float starClipDistanceSqr;

        private ParticleSystem particleSystem;
        private ParticleSystem.Particle[] points;

        private void Start()
        {
            _transform = transform;
            particleSystem = GetComponent<ParticleSystem>();
            starClipDistanceSqr = StarClipDistance * StarClipDistance;
        }

        private void CreateStars()
        {
            points = new ParticleSystem.Particle[MaxStars];

            for (int i = 0; i < MaxStars; i++)
            {
                points[i].position = Random.insideUnitSphere * StarDistance + _transform.position;
                points[i].color = new Color(1, 1, 1, 1);
                points[i].size = StarSize;
            }
        }

        private void Update()
        {
            if (points == null)
                CreateStars();

            for (int i = 0; i < MaxStars; i++)
            {
                if ((points[i].position - _transform.position).sqrMagnitude > starDistanceSqr)
                    points[i].position = Random.insideUnitSphere.normalized * StarDistance + _transform.position;

                if ((points[i].position - _transform.position).sqrMagnitude <= StarClipDistance)
                {
                    float percent = (points[i].position - _transform.position).sqrMagnitude / StarClipDistance;
                    points[i].startColor = new Color(1, 1, 1, percent);
                    points[i].size = percent * StarSize;
                }
                
                particleSystem.SetParticles(points, points.Length);
            }
        }
    }
}

