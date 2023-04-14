using System;
namespace Raylib
{
	// ModelAnimation
	[CRepr]
	public struct ModelAnimation
	{
	    public int32 		boneCount;			// Number of bones
	    public int32 		frameCount;			// Number of animation frames
	    public BoneInfo* 	bones;				// Bones information (skeleton)
	    public Transform** 	framePoses;      	// Poses array by frame
	}
}
