namespace Raylib;

using System;

public extension Texture
{
	public static Texture Load(StringView fileName)
	{
		return LoadTexture(fileName.Ptr);
	}

	public void Unload() mut
	{
		UnloadTexture(texture: this);
		this = default;
	}

	public void Update(void* pixels) mut
	{
		UpdateTexture(texture: this, pixels);
	}

	public void Update(void* pixels, Rectangle rect) mut
	{
		UpdateTextureRec(texture: this, rect, pixels);
	}

	public Image GetData()
	{
		return GetTextureData(texture: this);
	}

	public void GenMipmaps() mut
	{
		GenTextureMipmaps(texture: &this);
	}

	public void SetFilter(TextureFilter filter) mut
	{
		SetTextureFilter(texture: this, filter);
	}

	public void SetWrap(TextureWrap wrap) mut
	{
		SetTextureWrap(texture: this, wrap);
	}
}