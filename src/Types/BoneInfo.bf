using System;
namespace raylib_beef.Types
{
	[CRepr]
	public struct BoneInfo
	{
	    public char8[32] name;        // Bone name
	    public int parent;         // Bone parent
	}
}
