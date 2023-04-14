using System.Interop;

namespace Raylib
{
	// Gestures type
	// NOTE: It could be used as flags to enable only some gestures
	public enum GestureType	: c_int
	{
	    GESTURE_NONE        = 0,
	    GESTURE_TAP         = 1,
	    GESTURE_DOUBLETAP   = 2,
	    GESTURE_HOLD        = 4,
	    GESTURE_DRAG        = 8,
	    GESTURE_SWIPE_RIGHT = 16,
	    GESTURE_SWIPE_LEFT  = 32,
	    GESTURE_SWIPE_UP    = 64,
	    GESTURE_SWIPE_DOWN  = 128,
	    GESTURE_PINCH_IN    = 256,
	    GESTURE_PINCH_OUT   = 512
	}
}
