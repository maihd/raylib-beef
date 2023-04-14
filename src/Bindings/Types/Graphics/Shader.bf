using System;

namespace Raylib
{
	// Shader
	[CRepr]
	public struct Shader
	{
		public uint32 id;	// Shader program id
		public int32* locs;	// Shader locations array (RL_MAX_SHADER_LOCATIONS)
	}
}
