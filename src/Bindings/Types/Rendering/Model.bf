using System;

namespace Raylib
{
	// Model, meshes, materials and animation data
	[CRepr]
	public struct Model
	{
		public Matrix 		transform;		// Local transform matrix

		public int32 		meshCount;		// Number of meshes
		public int32 		materialCount;	// Number of materials
		public Mesh* 		meshes;			// Meshes array
		public Material* 	materials;		// Materials array
		public int32* 		meshMaterial;	// Mesh material number

		public int32 		boneCount;		// Number of bones
		public BoneInfo* 	bones;			// Bones information (skeleton)
		public Transform* 	bindPose;		// Bones base transformation (pose)
	}
}
