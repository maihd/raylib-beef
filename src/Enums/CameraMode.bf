using System.Interop;

namespace Raylib
{
	// Camera system modes
	public enum CameraMode : c_int
	{
		CAMERA_CUSTOM = 0,
		CAMERA_FREE,
		CAMERA_ORBITAL,
		CAMERA_FIRST_PERSON,
		CAMERA_THIRD_PERSON
	}
}
