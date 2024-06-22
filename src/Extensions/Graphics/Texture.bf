namespace Raylib;

using System;

public extension Texture
{
	[Inline]
	public static Texture Load(StringView fileName)
	{
		return LoadTexture(fileName.Ptr);
	}

	[Inline]
	public void Unload() mut
	{
		UnloadTexture(texture: this);
		this = default;
	}

	[Inline]
	public void Update(void* pixels) mut
	{
		UpdateTexture(texture: this, pixels);
	}

	[Inline]
	public void Update(void* pixels, Rectangle rect) mut
	{
		UpdateTextureRec(texture: this, rect, pixels);
	}

	[Inline]
	public Image GetData()
	{
		return GetTextureData(texture: this);
	}

	[Inline]
	public void GenMipmaps() mut
	{
		GenTextureMipmaps(texture: &this);
	}

	[Inline]
	public void SetFilter(TextureFilter filter) mut
	{
		SetTextureFilter(texture: this, filter);
	}

	[Inline]
	public void SetWrap(TextureWrap wrap) mut
	{
		SetTextureWrap(texture: this, wrap);
	}
}