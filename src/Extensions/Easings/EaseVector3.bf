namespace Raylib;

using System;

static
{
    // Linear Easing functions
    [Inline]
    public static Vector3 EaseLinearNone(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseLinearNone(t, s.x, e.x, 1.0f), EaseLinearNone(t, s.y, e.y, 1.0f), EaseLinearNone(t, s.z, e.z, 1.0f));
    }

    [Inline]
    public static Vector3 EaseLinearIn(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseLinearIn(t, s.x, e.x, 1.0f), EaseLinearIn(t, s.y, e.y, 1.0f), EaseLinearIn(t, s.z, e.z, 1.0f));
    }

    [Inline]
    public static Vector3 EaseLinearOut(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseLinearOut(t, s.x, e.x, 1.0f), EaseLinearOut(t, s.y, e.y, 1.0f), EaseLinearOut(t, s.z, e.z, 1.0f));
    }

    [Inline]
    public static Vector3 EaseLinearInOut(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseLinearInOut(t, s.x, e.x, 1.0f), EaseLinearInOut(t, s.y, e.y, 1.0f), EaseLinearInOut(t, s.z, e.z, 1.0f));
    }

    // Sine Easing functions
    [Inline]
    public static Vector3 EaseSineIn(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseSineIn(t, s.x, e.x, 1.0f), EaseSineIn(t, s.y, e.y, 1.0f), EaseSineIn(t, s.z, e.z, 1.0f));
    }

    [Inline]
    public static Vector3 EaseSineOut(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseSineOut(t, s.x, e.x, 1.0f), EaseSineOut(t, s.y, e.y, 1.0f), EaseSineOut(t, s.z, e.z, 1.0f));
    }

    [Inline]
    public static Vector3 EaseSineInOut(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseSineInOut(t, s.x, e.x, 1.0f), EaseSineInOut(t, s.y, e.y, 1.0f), EaseSineInOut(t, s.z, e.z, 1.0f));
    }

    // Circular Easing functions
    [Inline]
    public static Vector3 EaseCircIn(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseCircIn(t, s.x, e.x, 1.0f), EaseCircIn(t, s.y, e.y, 1.0f), EaseCircIn(t, s.z, e.z, 1.0f));
    }

    [Inline]
    public static Vector3 EaseCircOut(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseCircOut(t, s.x, e.x, 1.0f), EaseCircOut(t, s.y, e.y, 1.0f), EaseCircOut(t, s.z, e.z, 1.0f));
    }

    [Inline]
    public static Vector3 EaseCircInOut(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseCircInOut(t, s.x, e.x, 1.0f), EaseCircInOut(t, s.y, e.y, 1.0f), EaseCircInOut(t, s.z, e.z, 1.0f));
    }

    // Cubic Easing functions
    [Inline]
    public static Vector3 EaseCubicIn(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseCubicIn(t, s.x, e.x, 1.0f), EaseCubicIn(t, s.y, e.y, 1.0f), EaseCubicIn(t, s.z, e.z, 1.0f));
    }

    [Inline]
    public static Vector3 EaseCubicOut(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseCubicOut(t, s.x, e.x, 1.0f), EaseCubicOut(t, s.y, e.y, 1.0f), EaseCubicOut(t, s.z, e.z, 1.0f));
    }

    [Inline]
    public static Vector3 EaseCubicInOut(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseCubicInOut(t, s.x, e.x, 1.0f), EaseCubicInOut(t, s.y, e.y, 1.0f), EaseCubicInOut(t, s.z, e.z, 1.0f));
    }

    // Quadratic Easing functions
    [Inline]
    public static Vector3 EaseQuadIn(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseQuadIn(t, s.x, e.x, 1.0f), EaseQuadIn(t, s.y, e.y, 1.0f), EaseQuadIn(t, s.z, e.z, 1.0f));
    }

    [Inline]
    public static Vector3 EaseQuadOut(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseQuadOut(t, s.x, e.x, 1.0f), EaseQuadOut(t, s.y, e.y, 1.0f), EaseQuadOut(t, s.z, e.z, 1.0f));
    }

    [Inline]
    public static Vector3 EaseQuadInOut(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseQuadInOut(t, s.x, e.x, 1.0f), EaseQuadInOut(t, s.y, e.y, 1.0f), EaseQuadInOut(t, s.z, e.z, 1.0f));
    }

    // Exponential Easing functions
    [Inline]
    public static Vector3 EaseExpoIn(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseExpoIn(t, s.x, e.x, 1.0f), EaseExpoIn(t, s.y, e.y, 1.0f), EaseExpoIn(t, s.z, e.z, 1.0f));
    }

    [Inline]
    public static Vector3 EaseExpoOut(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseExpoOut(t, s.x, e.x, 1.0f), EaseExpoOut(t, s.y, e.y, 1.0f), EaseExpoOut(t, s.z, e.z, 1.0f));
    }

    [Inline]
    public static Vector3 EaseExpoInOut(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseExpoInOut(t, s.x, e.x, 1.0f), EaseExpoInOut(t, s.y, e.y, 1.0f), EaseExpoInOut(t, s.z, e.z, 1.0f));
    }

    // Back Easing functions
    [Inline]
    public static Vector3 EaseBackIn(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseBackIn(t, s.x, e.x, 1.0f), EaseBackIn(t, s.y, e.y, 1.0f), EaseBackIn(t, s.z, e.z, 1.0f));
    }

    [Inline]
    public static Vector3 EaseBackOut(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseBackOut(t, s.x, e.x, 1.0f), EaseBackOut(t, s.y, e.y, 1.0f), EaseBackOut(t, s.z, e.z, 1.0f));
    }

    [Inline]
    public static Vector3 EaseBackInOut(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseBackInOut(t, s.x, e.x, 1.0f), EaseBackInOut(t, s.y, e.y, 1.0f), EaseBackInOut(t, s.z, e.z, 1.0f));
    }

    // Bounce Easing functions
    [Inline]
    public static Vector3 EaseBounceOut(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseBounceOut(t, s.x, e.x, 1.0f), EaseBounceOut(t, s.y, e.y, 1.0f), EaseBounceOut(t, s.z, e.z, 1.0f));
    }

    [Inline]
    public static Vector3 EaseBounceIn(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseBounceIn(t, s.x, e.x, 1.0f), EaseBounceIn(t, s.y, e.y, 1.0f), EaseBounceIn(t, s.z, e.z, 1.0f));
    }

    [Inline]
    public static Vector3 EaseBounceInOut(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseBounceInOut(t, s.x, e.x, 1.0f), EaseBounceInOut(t, s.y, e.y, 1.0f), EaseBounceInOut(t, s.z, e.z, 1.0f));
    }

    // Elastic Easing functions
    [Inline]
    public static Vector3 EaseElasticIn(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseElasticIn(t, s.x, e.x, 1.0f), EaseElasticIn(t, s.y, e.y, 1.0f), EaseElasticIn(t, s.z, e.z, 1.0f));
    }

    [Inline]
    public static Vector3 EaseElasticOut(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseElasticOut(t, s.x, e.x, 1.0f), EaseElasticOut(t, s.y, e.y, 1.0f), EaseElasticOut(t, s.z, e.z, 1.0f));
    }

    [Inline]
    public static Vector3 EaseElasticInOut(Vector3 s, Vector3 e, float t)
    {
    	return .(EaseElasticInOut(t, s.x, e.x, 1.0f), EaseElasticInOut(t, s.y, e.y, 1.0f), EaseElasticInOut(t, s.z, e.z, 1.0f));
    }
}