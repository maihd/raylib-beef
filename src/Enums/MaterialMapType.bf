using System.Interop;
using System;

namespace Raylib
{
	// Material map type
	[AllowDuplicates]
	public enum MaterialMapType : c_int
	{
		MATERIAL_MAP_ALBEDO = 0,		// MATERIAL_MAP_DIFFUSE
		MATERIAL_MAP_METALNESS = 1,		// MATERIAL_MAP_SPECULAR
		MATERIAL_MAP_NORMAL = 2,
		MATERIAL_MAP_ROUGHNESS = 3,
		MATERIAL_MAP_OCCLUSION,
		MATERIAL_MAP_EMISSION,
		MATERIAL_MAP_HEIGHT,
		MATERIAL_MAP_BRDG,
		MATERIAL_MAP_CUBEMAP,			// NOTE: Uses GL_TEXTURE_CUBE_MAP
		MATERIAL_MAP_IRRADIANCE,		// NOTE: Uses GL_TEXTURE_CUBE_MAP
		MATERIAL_MAP_PREFILTER,			// NOTE: Uses GL_TEXTURE_CUBE_MAP

		MATERIAL_MAP_DIFFUSE = MATERIAL_MAP_ALBEDO,
		MATERIAL_MAP_SPECULAR = MATERIAL_MAP_METALNESS
	}
}
