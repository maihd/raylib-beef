using System;

namespace Raylib
{
	/// Wave, audio wave data
	[CRepr]
	public struct Wave
	{
		public uint32 	frameCount;		// Total number of frames (considering channels)
		public uint32 	sampleRate;		// Frequency (samples per second)
		public uint32 	sampleSize;		// Bit depth (bits per sample): 8, 16, 32 (24 not supported)
		public uint32 	channels;		// Number of channels (1-mono, 2-stereo)
		public void* 	data;			// Buffer data pointer
	}
}
