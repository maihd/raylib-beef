using System;

namespace Raylib
{
	// VrDeviceInfo, Head-Mounted-Display device parameters
	[CRepr]
	public struct VrDeviceInfo
	{
		public int32 	hResolution;			// Horizontal resolution in pixels
		public int32 	vResolution;			// Vertical resolution in pixels
		public float 	hScreenSize;			// Horizontal size in meters
		public float 	vScreenSize;			// Vertical size in meters
		public float 	vScreenCenter;			// Screen center in meters
		public float 	eyeToScreenDistance;	// Distance between eye and display in meters
		public float 	lensSeparationDistance;	// Lens separation distance in meters
		public float 	interpupillaryDistance;	// IPD (distance between pupils) in meters

		public float[4] lensDistortionValues;	// Lens distortion constant parameters
		public float[4] chromaAbCorrection;		// Chromatic aberration correction parameters
	}
}
