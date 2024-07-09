namespace System;

public extension Math
{
    [Union]
    private struct F2I
    {
        public float f;
        public int   i;
    }

    /// <summary>
	/// Computes inverse square root of 'x', using famous FastInvSqrt algorithm.
    /// <summary>
    public static float FastInvSqrt(float x)
    {
        F2I cvt;
        float xhalf = 0.5f * x;
        cvt.f = x;
        cvt.i = 0x5f3759df - (cvt.i >> 1); 
        cvt.f = cvt.f * (1.5f - xhalf * cvt.f * cvt.f); // first approximation
        cvt.f = cvt.f * (1.5f - xhalf * cvt.f * cvt.f); // second approximation, now CPU have good performance, this is not much, but have good precision
        return cvt.f;
    }
}