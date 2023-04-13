using System;

namespace Raylib
{
	struct rAudioBuffer;
	struct rAudioProcessor;

	[CRepr]
	public struct AudioStream
	{
    	public rAudioBuffer* 	buffer;       	// Pointer to internal data used by the audio system
    	public rAudioProcessor* processor; 		// Pointer to internal data processor, useful for audio effects

	    public uint32 			sampleRate;     // Frequency (samples per second)
	    public uint32 			sampleSize;     // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
	    public uint32 			channels;       // Number of channels (1-mono, 2-stereo)
	}
}
