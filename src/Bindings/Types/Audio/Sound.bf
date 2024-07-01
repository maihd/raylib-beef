using System;

namespace Raylib
{
	/// Sound
	[CRepr]
	public struct Sound
	{
		public AudioStream 	stream;		// Audio stream
		public uint32 		frameCount;	// Total number of frames (considering channels)
	}
}
