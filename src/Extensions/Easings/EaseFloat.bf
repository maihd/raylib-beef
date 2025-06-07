namespace Raylib;

using System;

static
{
    // Linear Easing functions
    [Inline]
	public static float EaseLinearNone(float s, float e, float t)
	{
		return EaseLinearNone(t, s, e, 1.0f);
	}

    [Inline]
	public static float EaseLinearIn(float s, float e, float t)
	{
		return EaseLinearIn(t, s, e, 1.0f);
	}
    
    [Inline]
	public static float EaseLinearOut(float s, float e, float t)
	{
		return EaseLinearOut(t, s, e, 1.0f);
	}
    
    [Inline]
	public static float EaseLinearInOut(float s, float e, float t)
	{
		return EaseLinearInOut(t, s, e, 1.0f);
	}

	// Sine Easing functions
    [Inline]
	public static float EaseSineIn(float s, float e, float t)
	{
		return EaseSineIn(t, s, e, 1.0f);
	}
    
    [Inline]
	public static float EaseSineOut(float s, float e, float t)
	{
		return EaseSineOut(t, s, e, 1.0f);
	}
    
    [Inline]
	public static float EaseSineInOut(float s, float e, float t)
	{
		return EaseSineInOut(t, s, e, 1.0f);
	}

	// Circular Easing functions
    [Inline]
	public static float EaseCircIn(float s, float e, float t)
	{
		return EaseCircIn(t, s, e, 1.0f);
	}
    
    [Inline]
	public static float EaseCircOut(float s, float e, float t)
	{
		return EaseCircOut(t, s, e, 1.0f);
	}
    
    [Inline]
	public static float EaseCircInOut(float s, float e, float t)
	{
		return EaseCircInOut(t, s, e, 1.0f);
	}

	// Cubic Easing functions
    [Inline]
	public static float EaseCubicIn(float s, float e, float t)
	{
		return EaseCubicIn(t, s, e, 1.0f);
	}
    
    [Inline]
	public static float EaseCubicOut(float s, float e, float t)
	{
		return EaseCubicOut(t, s, e, 1.0f);
	}
    
    [Inline]
	public static float EaseCubicInOut(float s, float e, float t)
	{
		return EaseCubicInOut(t, s, e, 1.0f);
	}

	// Quadratic Easing functions
    [Inline]
	public static float EaseQuadIn(float s, float e, float t)
	{
		return EaseQuadIn(t, s, e, 1.0f);
	}
    
    [Inline]
	public static float EaseQuadOut(float s, float e, float t)
	{
		return EaseQuadOut(t, s, e, 1.0f);
	}
    
    [Inline]
	public static float EaseQuadInOut(float s, float e, float t)
	{
		return EaseQuadInOut(t, s, e, 1.0f);
	}

	// Exponential Easing functions
    [Inline]
	public static float EaseExpoIn(float s, float e, float t)
	{
		return EaseExpoIn(t, s, e, 1.0f);
	}
    
    [Inline]
	public static float EaseExpoOut(float s, float e, float t)
	{
		return EaseExpoOut(t, s, e, 1.0f);
	}
    
    [Inline]
	public static float EaseExpoInOut(float s, float e, float t)
	{
		return EaseExpoInOut(t, s, e, 1.0f);
	}

	// Back Easing functions
    [Inline]
	public static float EaseBackIn(float s, float e, float t)
	{
		return EaseBackIn(t, s, e, 1.0f);
	}
    
    [Inline]
	public static float EaseBackOut(float s, float e, float t)
	{
		return EaseBackOut(t, s, e, 1.0f);
	}
    
    [Inline]
	public static float EaseBackInOut(float s, float e, float t)
	{
		return EaseBackInOut(t, s, e, 1.0f);
	}

	// Bounce Easing functions
    [Inline]
	public static float EaseBounceOut(float s, float e, float t)
	{
		return EaseBounceOut(t, s, e, 1.0f);
	}
    
    [Inline]
	public static float EaseBounceIn(float s, float e, float t)
	{
		return EaseBounceIn(t, s, e, 1.0f);
	}
    
    [Inline]
	public static float EaseBounceInOut(float s, float e, float t)
	{
		return EaseBounceInOut(t, s, e, 1.0f);
	}

	// Elastic Easing functions
    [Inline]
	public static float EaseElasticIn(float s, float e, float t)
	{
		return EaseElasticIn(t, s, e, 1.0f);
	}

    [Inline]
	public static float EaseElasticOut(float s, float e, float t)
	{
		return EaseElasticOut(t, s, e, 1.0f);
	}

    [Inline]
	public static float EaseElasticInOut(float s, float e, float t)
	{
		return EaseElasticInOut(t, s, e, 1.0f);
	}
}