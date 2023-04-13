using System;
namespace Raylib
{
	[CRepr]
	public struct Music
	{
		public AudioStream 			stream;		// Audio stream
		public int32 				frameCount;	// Total number of frames (considering channels)
		public bool					looping;	// Music looping enable

		public MusicContextType		ctxType;	// Type of music context (audio filetype)
		public void* 				ctxData;	// Audio context data, depends on type
	}
}
