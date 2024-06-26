using System;

namespace Raylib
{
    [Swizzle(4, HasColor=true)]
	public extension Vector4
	{
		[Inline]
		public this(float x, float y, float z, float w)
		{
			this.x = x;
			this.y = y;
			this.z = z;
			this.w = w;
		}

		[Inline]
		public this(float value)
		{
			x = value;
			y = value;
			z = value;
			w = value;
		}

		[Inline]
		public this()
		{
			this = default;
		}

		/// Computes the length of a Vector4
		[Inline]
		public float Length()
		{
			return Math.Sqrt(
				this.x * this.x +
				this.y * this.y +
				this.z * this.z +
				this.w * this.w);
		}

		/// Computes the length of a Vector4
		[Inline]
		public float LengthSqr()
		{
			return (
				this.x * this.x +
				this.y * this.y +
				this.z * this.z +
				this.w * this.w);
		}

		[Inline]
		/// Normalize provided vector
		public Vector4 Normalize()
		{
			return this * (1.0f / Length());
		}

#region operators        

		[Inline]
		public static Vector4 operator+(Vector4 q1, Vector4 q2)
		{
			return .(q1.x + q2.x, q1.y + q2.y, q1.z + q2.z, q1.w + q2.w);
		}

		[Inline, Commutable]
		public static Vector4 operator+(Vector4 q, float add)
		{
			return .(q.x + add, q.y + add, q.z + add, q.w + add);
		}

		[Inline]
		public static Vector4 operator-(Vector4 q1, Vector4 q2)
		{
			return .(q1.x - q2.x, q1.y - q2.y, q1.z - q2.z, q1.w - q2.w);
		}

		[Inline]
		public static Vector4 operator-(Vector4 q, float sub)
		{
			return .(q.x - sub, q.y - sub, q.z - sub, q.w - sub);
		}
		
        [Inline]
        public static Vector4 operator-(float sub, Vector4 v)
        {
        	return .(sub - v.x, sub - v.y, sub - v.z, sub - v.w);
        }

        [Inline]
        public static Vector4 operator*(Vector4 v1, Vector4 v2)
        {
            return .(v1.x * v2.x, v1.y * v2.y, v1.z * v2.z, v1.w * v2.w);
        }

        [Inline, Commutable]
        public static Vector4 operator*(Vector4 v, float s)
        {
            return .(v.x * s, v.y * s, v.z * s, v.w * s);
        }

        [Inline]
        public static Vector4 operator/(Vector4 v1, Vector4 v2)
        {
            return .(v1.x / v2.x, v1.y / v2.y, v1.z / v2.z, v1.w / v2.w);
        }

        [Inline]
        public static Vector4 operator/(Vector4 v, float s)
        {
            return .(v.x / s, v.y / s, v.z / s, v.w / s);
        }

        [Inline]
        public static Vector4 operator/(float s, Vector4 v)
        {
            return .(s / v.x, s / v.y, s / v.z, s / v.w);
        }

		[Inline]
		public static bool operator==(Vector4 v1, Vector4 v2)
		{
			return (
				v1.x == v2.x &&
				v1.y == v2.y &&
				v1.z == v2.z &&
				v1.w == v2.w);
		}

		[Inline]
		public static bool operator!=(Vector4 v1, Vector4 v2)
		{
			return !(v1 == v2);
		}

		[Inline]
		public static bool operator>(Vector4 v1, Vector4 v2)
		{
			return v1.x > v2.x && v1.y > v2.y && v1.z > v2.z && v1.w > v2.w;
		}

		[Inline]
		public static bool operator<(Vector4 v1, Vector4 v2)
		{
			return v1.x < v2.x && v1.y < v2.y && v1.z < v2.z && v1.w < v2.w;
		}
#endregion
	}
}
