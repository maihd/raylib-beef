using System;
using System.Interop;

namespace Raylib
{
	// Font, font texture and GlyphInfo array data
	[CRepr]
	public struct Font
	{
		public int32 baseSize;		// Base size (default chars height)
		public int32 glyphCount;	// Number of glyph characters
		public int32 glyphPadding;	// Padding around the glyph characters

		public Texture2D texture;	// Texture atlas containing the glyphs
		public Rectangle* recs;		// Rectangles in texture for the glyphs
		public GlyphInfo* glyphs;	// Glyphs info data
	}
}
