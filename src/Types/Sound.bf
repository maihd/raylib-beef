using System;
namespace Raylib.Types
{
	[CRepr]
	public struct Sound
	{
		public uint32 sampleCount;// Total number of samples
		public AudioStream stream;// Audio stream
	}
}
