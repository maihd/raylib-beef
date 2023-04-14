using System;

namespace Raylib
{
	// Bone, skeletal animation bone
	[CRepr]
	public struct BoneInfo
	{
	    public char8[32] 	name;		// Bone name
	    public int32 		parent;		// Bone parent
	}
}
