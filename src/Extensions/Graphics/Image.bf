namespace Raylib;

using System;

public extension Image
{
	public static Image Load(StringView fileName)
	{
		return LoadImage(fileName.Ptr);
	}

	public static Image Load(StringView fileName, int32 width, int32 height, int32 format, int32 headerSize)
	{
		return LoadImageRaw(fileName.Ptr, width, height, format, headerSize);
	}

	public static Image LoadAnim(StringView fileName, out int32 frames)
	{
		return LoadImageAnim(fileName.Ptr, out frames);
	}

	public static Image FromMemory(StringView fileType, uint8* fileData, int32 dataSize)
	{
		return LoadImageFromMemory(fileType.Ptr, fileData, dataSize);
	}
}