using System;
namespace Raylib
{
	[CRepr]
	public struct MaterialMap
	{
	    public Texture2D texture;        // Material map texture
	    public Color color;              // Material map color
	    public float value;              // Material map value
	}
}
