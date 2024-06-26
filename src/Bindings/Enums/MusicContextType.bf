namespace Raylib;

public enum MusicContextType : uint32
{
	MUSIC_AUDIO_NONE = 0,   // No audio context loaded
	MUSIC_AUDIO_WAV,        // WAV audio context
	MUSIC_AUDIO_OGG,        // OGG audio context
	MUSIC_AUDIO_FLAC,       // FLAC audio context
	MUSIC_AUDIO_MP3,        // MP3 audio context
	MUSIC_AUDIO_QOA,        // QOA audio context
	MUSIC_MODULE_XM,        // XM module audio context
	MUSIC_MODULE_MOD        // MOD module audio context
}