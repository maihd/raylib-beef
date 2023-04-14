using System;

namespace Raylib
{
	static
	{
		[CLink]
		/// Load VR stereo config for VR simulator device parameters
		public static extern VrStereoConfig LoadVrStereoConfig(VrDeviceInfo device);                 // Load VR stereo config for VR simulator device parameters

		[CLink]
		/// Unload VR stereo config
		public static extern void UnloadVrStereoConfig(VrStereoConfig config);      
	}
}
