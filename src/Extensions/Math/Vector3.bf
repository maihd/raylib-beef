using System;

namespace Raylib
{
    [Swizzle(3, HasColor=true)]
	public extension Vector3
	{
#region Common values/constants
        public const Vector3 Zero      = .( 0.0f,  0.0f,  0.0f);
        public const Vector3 One       = .( 1.0f,  1.0f,  1.0f);

        public const Vector3 UnitX     = .( 1.0f,  0.0f,  0.0f);
        public const Vector3 UnitY     = .( 0.0f,  1.0f,  0.0f);
        public const Vector3 UnitZ     = .( 0.0f,  0.0f,  1.0f);

        public const Vector3 Left      = .(-1.0f,  0.0f,  0.0f);
        public const Vector3 Right     = .( 1.0f,  0.0f,  0.0f);

        public const Vector3 Up        = .( 0.0f,  1.0f,  0.0f);
        public const Vector3 Down      = .( 0.0f, -1.0f,  0.0f);

        public const Vector3 Forward   = .( 0.0f,  0.0f,  1.0f);
        public const Vector3 Backward  = .( 0.0f,  0.0f, -1.0f);
#endregion

		[Inline]
		public this(float x, float y, float z = 0.0f)
		{
			this.x = x;
			this.y = y;
			this.z = z;
		}

		[Inline]
		public this(float value)
		{
			this.x = value;
			this.y = value;
			this.z = value;
		}

        [Inline]
        public this(Vector2 v2, float z = 0.0f)
        {
            this.x = v2.x;
            this.y = v2.y;
            this.z = z;
        }

		[Inline]
		public this()
		{
			this = default;
		}

#region Properties
        /// Get vector length
        [Inline]
        public float length => Length();

        /// Get vector square length
        [Inline]
        public float lengthSqr => LengthSqr();

        /// Get normalized vector
        [Inline]
        public Vector3 normalized => this * (1.0f / length);
#endregion
        

#region Methods
		public override void ToString(String outString)
		{
			outString.AppendF(scope $"Vector3({x:00.0}, {y:00.0}, {z:00.0})");
		}
        
        /// Calculate two vectors cross product
		[Inline]
		public Vector3 Cross(Vector3 v2)
		{
			return .(
				this.y * v2.z - this.z * v2.y,
				this.z * v2.x - this.x * v2.z,
				this.x * v2.y - this.y * v2.x
				);
		}
        
        /// Calculate one vector perpendicular vector
		[Inline]
		public Vector3 Perpendicular()
		{
			Vector3 result = default;

			float min = Math.Abs(this.x);
			Vector3 cardinalAxis = .(1.0f, 0.0f, 0.0f);

			if (Math.Abs(this.y) < min)
			{
				min = Math.Abs(this.y);
				Vector3 tmp = .(0.0f, 1.0f, 0.0f);
				cardinalAxis = tmp;
			}

			if (Math.Abs(this.z) < min)
			{
				Vector3 tmp = .(0.0f, 0.0f, 1.0f);
				cardinalAxis = tmp;
			}

			result = Cross(cardinalAxis);

			return result;
		}
        
        /// Calculate vector length
		[Inline]
		public float Length()
		{
			return Math.Sqrt(
				this.x * this.x +
				this.y * this.y +
				this.z * this.z
			);
		}
        
        /// Calculate vector square length
		[Inline]
		public float LengthSqr()
		{
			return (this.x * this.x + this.y * this.y + this.z * this.z);
		}
        
        /// Calculate vector square length
		[Inline]
		public float Dot(Vector3 v2)
		{
			return (this.x * v2.x + this.y * v2.y + this.z * v2.z);
		}
        
        ///  Calculate distance between two vectors
		[Inline]
		public float Distance(Vector3 v2)
		{
			float dx = v2.x - this.x;
			float dy = v2.y - this.y;
			float dz = v2.z - this.z;
			float result = Math.Sqrt(dx * dx + dy * dy + dz * dz);
			return result;
		}
        
        /// Normalize provided vector
		[Inline]
		public Vector3 Normalize()
		{
			Vector3 result = default;


			float length, ilength;
			length = Length();

			if (length == 0.0f)
				length = 1.0f;

			ilength = 1.0f / length;

			result.x *= ilength;
			result.y *= ilength;
			result.z *= ilength;

			return result;
		}
        
        /// Orthonormalize provided vectors
        /// Makes vectors normalized and orthogonal to each other
        /// Gram-Schmidt function implementation
		[Inline]
		public void OrthoNormalize(Vector3* v2) mut
		{
			this = this.Normalize();
			Vector3 vn = this.Cross(*v2);
			vn.Normalize();
			*v2 = vn.Cross(this);
		}
        
        ///  Transforms a Vector3 by a given Matrix
		[Inline]
		public Vector3 Transform(Matrix mat)
		{
			Vector3 result = default;
			float x = this.x;
			float y = this.y;
			float z = this.z;

			result.x = mat.m0 * x + mat.m4 * y + mat.m8 * z + mat.m12;
			result.y = mat.m1 * x + mat.m5 * y + mat.m9 * z + mat.m13;
			result.z = mat.m2 * x + mat.m6 * y + mat.m10 * z + mat.m14;

			return result;
		}
        
        ///  Transform a vector by quaternion rotation
		[Inline]
		public Vector3 RotateByQuaternion(Quaternion q)
		{
			Vector3 result = default;

			result.x =
				this.x * (q.x * q.x + q.w * q.w - q.y * q.y - q.z * q.z) +
				this.y * (2 * q.x * q.y - 2 * q.w * q.z) +
				this.z * (2 * q.x * q.z + 2 * q.w * q.y);

			result.y =
				this.x * (2 * q.w * q.z + 2 * q.x * q.y) +
				this.y * (q.w * q.w - q.x * q.x + q.y * q.y - q.z * q.z) +
				this.z * (-2 * q.w * q.x + 2 * q.y * q.z);

			result.z =
				this.x * (-2 * q.w * q.y + 2 * q.x * q.z) +
				this.y * (2 * q.w * q.x + 2 * q.y * q.z) +
				this.z * (q.w * q.w - q.x * q.x - q.y * q.y + q.z * q.z);

			return result;
		}
        
        ///  Calculate linear interpolation between two vectors
		[Inline]
		public Vector3 Lerp(Vector3 v2, float amount)
		{
			Vector3 result = default;

			result.x = this.x + amount * (v2.x - this.x);
			result.y = this.y + amount * (v2.y - this.y);
			result.z = this.z + amount * (v2.z - this.z);

			return result;
		}
        
        ///  Calculate reflected vector to normal
		[Inline]
		public Vector3 Reflect(Vector3 normal)
		{
			// I is the original vector
			// N is the normal of the incident plane
			// R = I - (2*N*( DotProduct[ I,N] ))

			Vector3 result = default;

			float dotProduct = this.Dot(normal);

			result.x = this.x - (2.0f * normal.x) * dotProduct;
			result.y = this.y - (2.0f * normal.y) * dotProduct;
			result.z = this.z - (2.0f * normal.z) * dotProduct;

			return result;
		}
        
        ///  Return min value for each pair of components
		[Inline]
		public Vector3 Min(Vector3 v2)
		{
			Vector3 result = default;

			result.x = Math.Min<float>(this.x, v2.x);
			result.y = Math.Min<float>(this.y, v2.y);
			result.z = Math.Min<float>(this.z, v2.z);

			return result;
		}
        
        ///  Return max value for each pair of components
		[Inline]
		public Vector3 Max(Vector3 v2)
		{
			Vector3 result = default;

			result.x = Math.Max<float>(this.x, v2.x);
			result.y = Math.Max<float>(this.y, v2.y);
			result.z = Math.Max<float>(this.z, v2.z);

			return result;
		}
        
        /// Compute barycenter coordinates (u, v, w) for point p with respect to triangle (a, b, c)
        /// NOTE: Assumes P is on the plane of the triangle
		[Inline]
		public static Vector3 Barycenter(Vector3 p, Vector3 a, Vector3 b, Vector3 c)
		{
			Vector3 v0 = b - a;
			Vector3 v1 = c - a;
			Vector3 v2 = p - a;
			float d00 = v0.Dot(v0);
			float d01 = v0.Dot(v1);
			float d11 = v1.Dot(v1);
			float d20 = v2.Dot(v0);
			float d21 = v2.Dot(v1);

			float denom = d00 * d11 - d01 * d01;

			Vector3 result = default;

			result.y = (d11 * d20 - d01 * d21) / denom;
			result.z = (d00 * d21 - d01 * d20) / denom;
			result.x = 1.0f - (result.z + result.y);

			return result;
		}
        
        /// Returns Vector3 as float array
		[Inline]
		public float3 ToFloatV()
		{
			float3 buffer = default;

			buffer.v[0] = this.x;
			buffer.v[1] = this.y;
			buffer.v[2] = this.z;

			return buffer;
		}
        
        /// Projects a Vector3 from screen space into object space
		[Inline]
		public Vector3 Unproject(Matrix projection, Matrix view)
		{
			var source = this;
			Vector3 result = Vector3.Zero;

			// Calculate unproject matrix (multiply view patrix by projection matrix) and invert it
			Matrix matViewProj = view * projection;
			matViewProj = matViewProj.Invert();

			// Create quaternion from source point
			Quaternion quat = .(source.x, source.y, source.z, 1.0f);

			// Multiply quat point by unproject matrix
			quat = quat.Transform(matViewProj);

			// Normalized world points in vectors
			result.x = quat.x / quat.w;
			result.y = quat.y / quat.w;
			result.z = quat.z / quat.w;

			return result;
		}
#endregion

#region Operators
		[Inline]
		public static Vector3 operator+(Vector3 v)
		{
			return v;
		}

		[Inline]
		public static Vector3 operator-(Vector3 v)
		{
			return .(-v.x, -v.y, -v.z);
		}

		[Inline]
		public static Vector3 operator+(Vector3 v1, Vector3 v2)
		{
			return .(v1.x + v2.x, v1.y + v2.y, v1.z + v2.z);
		}

		[Inline, Commutable]
		public static Vector3 operator+(Vector3 v, float add)
		{
			return .(v.x + add, v.y + add, v.z + add);
		}

		[Inline]
		public static Vector3 operator-(Vector3 v1, Vector3 v2)
		{
			return .(v1.x - v2.x, v1.y - v2.y, v1.z - v2.z);
		}

		[Inline]
		public static Vector3 operator-(Vector3 v, float sub)
		{
			return .(v.x - sub, v.y - sub, v.z - sub);
		}

		[Inline]
		public static Vector3 operator/(Vector3 v1, Vector3 v2)
		{
			return .(v1.x / v2.x, v1.y / v2.y, v1.z / v2.z);
		}

		[Inline]
		public static Vector3 operator/(Vector3 v1, float div)
		{
			return .(v1.x / div, v1.y / div, v1.z / div);
		}

		[Inline, Commutable]
		public static Vector3 operator*(Vector3 v, float scalar)
		{
			return .(v.x * scalar, v.y * scalar, v.z * scalar);
		}

		[Inline]
		public static Vector3 operator*(Vector3 v1, Vector3 v2)
		{
			return .(v1.x * v2.x, v1.y * v2.y, v1.z * v2.z);
		}

		[Inline]
		public static bool operator==(Vector3 v1, Vector3 v2)
		{
			return (v1.x == v2.x && v1.y == v2.y && v1.z == v2.z);
		}

		[Inline]
		public static bool operator!=(Vector3 v1, Vector3 v2)
		{
			return !(v1 == v2);
		}

		[Inline]
		public static bool operator>(Vector3 v1, Vector3 v2)
		{
			return v1.x > v2.x && v1.y > v2.y && v1.z > v2.z;
		}

		[Inline]
		public static bool operator<(Vector3 v1, Vector3 v2)
		{
			return v1.x < v2.x && v1.y < v2.y && v1.z < v2.z;
		}
#endregion
	}
}
