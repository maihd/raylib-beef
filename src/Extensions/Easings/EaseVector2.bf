namespace Raylib;

using System;

static
{
    // Linear Easing functions
    [Inline]
    public static Vector2 EaseLinearNone(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseLinearNone(t, s.x, e.x, 1.0f), EaseLinearNone(t, s.y, e.y, 1.0f));
    }

    [Inline]
    public static Vector2 EaseLinearIn(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseLinearIn(t, s.x, e.x, 1.0f), EaseLinearIn(t, s.y, e.y, 1.0f));
    }

    [Inline]
    public static Vector2 EaseLinearOut(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseLinearOut(t, s.x, e.x, 1.0f), EaseLinearOut(t, s.y, e.y, 1.0f));
    }

    [Inline]
    public static Vector2 EaseLinearInOut(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseLinearInOut(t, s.x, e.x, 1.0f), EaseLinearInOut(t, s.y, e.y, 1.0f));
    }

    // Sine Easing functions
    [Inline]
    public static Vector2 EaseSineIn(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseSineIn(t, s.x, e.x, 1.0f), EaseSineIn(t, s.y, e.y, 1.0f));
    }

    [Inline]
    public static Vector2 EaseSineOut(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseSineOut(t, s.x, e.x, 1.0f), EaseSineOut(t, s.y, e.y, 1.0f));
    }

    [Inline]
    public static Vector2 EaseSineInOut(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseSineInOut(t, s.x, e.x, 1.0f), EaseSineInOut(t, s.y, e.y, 1.0f));
    }

    // Circular Easing functions
    [Inline]
    public static Vector2 EaseCircIn(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseCircIn(t, s.x, e.x, 1.0f), EaseCircIn(t, s.y, e.y, 1.0f));
    }

    [Inline]
    public static Vector2 EaseCircOut(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseCircOut(t, s.x, e.x, 1.0f), EaseCircOut(t, s.y, e.y, 1.0f));
    }

    [Inline]
    public static Vector2 EaseCircInOut(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseCircInOut(t, s.x, e.x, 1.0f), EaseCircInOut(t, s.y, e.y, 1.0f));
    }

    // Cubic Easing functions
    [Inline]
    public static Vector2 EaseCubicIn(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseCubicIn(t, s.x, e.x, 1.0f), EaseCubicIn(t, s.y, e.y, 1.0f));
    }

    [Inline]
    public static Vector2 EaseCubicOut(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseCubicOut(t, s.x, e.x, 1.0f), EaseCubicOut(t, s.y, e.y, 1.0f));
    }

    [Inline]
    public static Vector2 EaseCubicInOut(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseCubicInOut(t, s.x, e.x, 1.0f), EaseCubicInOut(t, s.y, e.y, 1.0f));
    }

    // Quadratic Easing functions
    [Inline]
    public static Vector2 EaseQuadIn(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseQuadIn(t, s.x, e.x, 1.0f), EaseQuadIn(t, s.y, e.y, 1.0f));
    }

    [Inline]
    public static Vector2 EaseQuadOut(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseQuadOut(t, s.x, e.x, 1.0f), EaseQuadOut(t, s.y, e.y, 1.0f));
    }

    [Inline]
    public static Vector2 EaseQuadInOut(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseQuadInOut(t, s.x, e.x, 1.0f), EaseQuadInOut(t, s.y, e.y, 1.0f));
    }

    // Exponential Easing functions
    [Inline]
    public static Vector2 EaseExpoIn(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseExpoIn(t, s.x, e.x, 1.0f), EaseExpoIn(t, s.y, e.y, 1.0f));
    }

    [Inline]
    public static Vector2 EaseExpoOut(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseExpoOut(t, s.x, e.x, 1.0f), EaseExpoOut(t, s.y, e.y, 1.0f));
    }

    [Inline]
    public static Vector2 EaseExpoInOut(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseExpoInOut(t, s.x, e.x, 1.0f), EaseExpoInOut(t, s.y, e.y, 1.0f));
    }

    // Back Easing functions
    [Inline]
    public static Vector2 EaseBackIn(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseBackIn(t, s.x, e.x, 1.0f), EaseBackIn(t, s.y, e.y, 1.0f));
    }

    [Inline]
    public static Vector2 EaseBackOut(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseBackOut(t, s.x, e.x, 1.0f), EaseBackOut(t, s.y, e.y, 1.0f));
    }

    [Inline]
    public static Vector2 EaseBackInOut(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseBackInOut(t, s.x, e.x, 1.0f), EaseBackInOut(t, s.y, e.y, 1.0f));
    }

    // Bounce Easing functions
    [Inline]
    public static Vector2 EaseBounceOut(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseBounceOut(t, s.x, e.x, 1.0f), EaseBounceOut(t, s.y, e.y, 1.0f));
    }

    [Inline]
    public static Vector2 EaseBounceIn(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseBounceIn(t, s.x, e.x, 1.0f), EaseBounceIn(t, s.y, e.y, 1.0f));
    }

    [Inline]
    public static Vector2 EaseBounceInOut(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseBounceInOut(t, s.x, e.x, 1.0f), EaseBounceInOut(t, s.y, e.y, 1.0f));
    }

    // Elastic Easing functions
    [Inline]
    public static Vector2 EaseElasticIn(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseElasticIn(t, s.x, e.x, 1.0f), EaseElasticIn(t, s.y, e.y, 1.0f));
    }

    [Inline]
    public static Vector2 EaseElasticOut(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseElasticOut(t, s.x, e.x, 1.0f), EaseElasticOut(t, s.y, e.y, 1.0f));
    }

    [Inline]
    public static Vector2 EaseElasticInOut(Vector2 s, Vector2 e, float t)
    {
    	return .(EaseElasticInOut(t, s.x, e.x, 1.0f), EaseElasticInOut(t, s.y, e.y, 1.0f));
    }
}