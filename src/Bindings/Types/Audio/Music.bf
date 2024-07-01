using System;
using System.Interop;

namespace Raylib
{
	/// Music, audio stream, anything longer than ~10 seconds should be streamed
	[CRepr]
	public struct Music
	{
		public AudioStream 			stream;		// Audio stream
		public uint32 				frameCount;	// Total number of frames (considering channels)
		public c_bool				looping;	// Music looping enable

		public MusicContextType		ctxType;	// Type of music context (audio filetype)
		public void* 				ctxData;	// Audio context data, depends on type
	}
}
