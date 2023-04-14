using System;

namespace Raylib
{
	// Material, includes shader and maps
	[CRepr]
	public struct Material
	{
		public Shader 		shader;		// Material shader
		public MaterialMap* maps;		// Material maps array (MAX_MATERIAL_MAPS)
		public float* 		param;		// Material generic parameters (if required)
	}
}
