using UnityEngine;

namespace Architecture
{
    public class AudioManager : BaseManager<AudioManager>
    {
        public AudioClip SceneMusic;
        public float MusicVolume;

        private AudioSource source;

        public void LoadSceneAudio(AudioClip sceneMusic, float musicVolume)
        {
            SceneMusic = sceneMusic;
            MusicVolume = musicVolume;

            PlaySceneMusic();
        }

        public void PlaySceneMusic()
        {
            source.volume = MusicVolume;
            source.clip = SceneMusic;
            source.Play();
        }

        protected override void OnAwake()
        {
            source = GetComponent<AudioSource>();
        }

        private void OnEnable()
        {

        }

        private void OnDisable()
        {

        }
    }
}
