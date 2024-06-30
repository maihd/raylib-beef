using System;

namespace Raylib
{
    [Swizzle(2)]
	public extension Vector2
	{
#region Common values/constants

		public const Vector2 Zero 	= .(0.0f);
		public const Vector2 One 	= .(1.0f);
		public const Vector2 UnitX 	= .(1.0f, 0.0f);
		public const Vector2 UnitY 	= .(0.0f, 1.0f);

		public const Vector2 Up		= .( 0.0f,  1.0f);
		public const Vector2 Down 	= .( 0.0f, -1.0f);
		public const Vector2 Left	= .(-1.0f,  0.0f);
		public const Vector2 Right  = .( 1.0f,  0.0f);

#endregion

		[Inline]
		public this()
		{
			this = default;
		}

		[Inline]
		public this(float x, float y)
		{
			this.x = x;
			this.y = y;
		}

		[Inline]
		public this(float value)
		{
			this.x = value;
			this.y = value;
		}

		public override void ToString(String outStr)
		{
			outStr.AppendF("Vector2({}, {})", x, y);
		}

#region Properties
		/// Get vector length
		[Inline]
		public float length => Length(this);
		
		/// Get vector square length
		[Inline]
		public float lengthSqr => LengthSqr(this);

		/// Get normalized vector
		public Vector2 normalized
		{
			[Inline]
			get
			{
				var v = this;
				v *= (1.0f / length);
				return v;
			}
		}
#endregion

#region Static Methods
		/// Calculate vector length
		[Inline]
		public static float Length(Vector2 v)
		{
			return Math.Sqrt((v.x * v.x) + (v.y * v.y));
		}

		/// Calculate vector square length
		[Inline]
		public static float LengthSqr(Vector2 v)
		{
			return (v.x * v.x) + (v.y * v.y);
		}

		/// Calculate two vectors dot product
		[Inline]
		public static float Dot(Vector2 v1, Vector2 v2)
		{
			return (v1.x * v2.x + v1.y * v2.y);
		}

		/// Calculate distance between two vectors
		[Inline]
		public static float Distance(Vector2 v1, Vector2 v2)
		{
			return Math.Sqrt((v1 - v2).length);
		}

		/// Calculate angle from two vectors in X-axis
		[Inline]
		public static float Angle(Vector2 v1, Vector2 v2)
		{
			var result = Math.Atan2(v2.y - v1.y, v2.x - v2.x) * 180 / Math.PI_f;
			if (result < 0) result += 360.0f;
			return result;
		}

		/// Calculate linear interpolation between two vectors
		[Inline]
		public static Vector2 Lerp(Vector2 v1, Vector2 v2, float amount)
		{
			Vector2 result = default;

			result.x = v1.x + amount * (v2.x - v1.x);
			result.y = v1.y + amount * (v2.y - v1.y);

			return result;
		}

		/// Calculate reflected vector to normal
		[Inline]
		public static Vector2 Reflect(Vector2 v, Vector2 normal)
		{
			Vector2 result = default;

			float dotProduct = Dot(v, normal);
			result.x = v.x - (2.0f * normal.x) * dotProduct;
			result.y = v.y - (2.0f * normal.y) * dotProduct;

			return result;
		}

		/// Rotate Vector by float in Degrees.
		[Inline]
		public static Vector2 Rotate(Vector2 v, float degs)
		{
			float rads = degs * Raylib.DEG2RAD;
			Vector2 result = .(
				v.x * Math.Cos(rads) - v.y * Math.Sin(rads),
				v.x * Math.Sin(rads) + v.y * Math.Cos(rads)
			);
			return result;
		}

		/// Move Vector towards target
		[Inline]
		public static Vector2 MoveTowards(Vector2 v, Vector2 target, float maxDistance)
		{
			Vector2 result = default;
			float dx = target.x - v.x;
			float dy = target.y - v.y;
			float value = (dx * dx) + (dy * dy);

			if ((value == 0) || ((maxDistance >= 0) &&
				(value <= maxDistance * maxDistance)))
				result = target;

			float dist = Math.Sqrt(value);

			result.x = v.x + dx / dist * maxDistance;
			result.y = v.y + dy / dist * maxDistance;

			return result;
		}
#endregion

#region Methods
		/// <summary>
		/// Normalize provided vector
		/// </summary>
		[Inline]
		public void Normalize() mut
		{
			this = normalized;
		}

		/// Move Vector towards target
		[Inline]
		public void MoveTowards(Vector2 target, float maxDistance) mut
		{
			this = MoveTowards(this, target, maxDistance);
		}
#endregion

#region Operators
		[Inline]
		public static Vector2 operator+(Vector2 v1, Vector2 v2)
		{
			return .(v1.x + v2.x, v1.y + v2.y);
		}

		[Inline, Commutable]
		public static Vector2 operator+(Vector2 v1, float f)
		{
			return .(v1.x + f, v1.y + f);
		}

		[Inline]
		public static Vector2 operator-(Vector2 v1, Vector2 v2)
		{
			return .(v1.x - v2.x, v1.y - v2.y);
		}

		[Inline]
		public static Vector2 operator-(Vector2 v1, float f)
		{
			return .(v1.x - f, v1.y - f);
		}

		[Inline]
		public static Vector2 operator-(float f, Vector2 v)
		{
			return .(f - v.x, f - v.y);
		}

		[Inline, Commutable]
		public static Vector2 operator*(Vector2 v, float scale)
		{
			return .(v.x * scale, v.y * scale);
		}

		[Inline]
		public static Vector2 operator*(Vector2 v1, Vector2 v2)
		{
			return .(v1.x * v2.x, v1.y * v2.y);
		}

		[Inline]
		public static Vector2 operator-(Vector2 v1)
		{
			return .(-v1.x, -v1.y);
		}

		[Inline]
		public static Vector2 operator/(Vector2 v1, Vector2 v2)
		{
			return .(v1.x / v2.x, v1.y / v2.y);
		}

		[Inline]
		public static Vector2 operator/(Vector2 v1, float div)
		{
			return .(v1.x / div, v1.y / div);
		}

		[Inline]
		public static bool operator==(Vector2 v1, Vector2 v2)
		{
			return (v1.x == v2.x && v1.y == v2.y);
		}

		[Inline]
		public static bool operator!=(Vector2 v1, Vector2 v2)
		{
			return !(v1 == v2);
		}

		[Inline]
		public static bool operator>(Vector2 v1, Vector2 v2)
		{
			return v1.x > v2.x && v1.y > v2.y;
		}

		[Inline]
		public static bool operator<(Vector2 v1, Vector2 v2)
		{
			return v1.x < v2.x && v1.y < v2.y;
		}
#endregion
	}
}
