using System;
using raylib_beef.Types;

namespace raylib_beef
{
	public static class Raymath
	{
		// Used by Import to load the native library.
		public const String nativeLibName = "raylib.dll";

		// Clamp float value
		[CLink]
		public static extern float Clamp(float value, float min, float max);

		// Calculate linear interpolation between two vectors
		[CLink]
		public static extern float Lerp(float start, float end, float amount);

		// Vector with components value 0.0f
		[CLink]
		public static extern Vector2 Vector2Zero();

		// Vector with components value 1.0f
		[CLink]
		public static extern Vector2 Vector2One();

		// Add two vectors (v1 + v2)
		[CLink]
		public static extern Vector2 Vector2Add(Vector2 v1, Vector2 v2);

		// Subtract two vectors (v1 - v2)
		[CLink]
		public static extern Vector2 Vector2Subtract(Vector2 v1, Vector2 v2);

		// Calculate vector length
		[CLink]
		public static extern float Vector2Length(Vector2 v);

		// Calculate two vectors dot product
		[CLink]
		public static extern float Vector2DotProduct(Vector2 v1, Vector2 v2);

		// Calculate distance between two vectors
		[CLink]
		public static extern float Vector2Distance(Vector2 v1, Vector2 v2);

		// Calculate angle from two vectors in X-axis
		[CLink]
		public static extern float Vector2Angle(Vector2 v1, Vector2 v2);

		// Scale vector (multiply by value)
		[CLink]
		public static extern Vector2 Vector2Scale(Vector2 v, float scale);

		// Multiply vector by vector
		[CLink]
		public static extern Vector2 Vector2MultiplyV(Vector2 v1, Vector2 v2);

		// Negate vector
		[CLink]
		public static extern Vector2 Vector2Negate(Vector2 v);

		// Divide vector by a float value
		[CLink]
		public static extern Vector2 Vector2Divide(Vector2 v, float div);

		// Divide vector by vector
		[CLink]
		public static extern Vector2 Vector2DivideV(Vector2 v1, Vector2 v2);

		// Normalize provided vector
		[CLink]
		public static extern Vector2 Vector2Normalize(Vector2 v);

		// Calculate linear interpolation between two vectors
		[CLink]
		public static extern Vector2 Vector2Lerp(Vector2 v1, Vector2 v2, float amount);

		// Vector with components value 0.0f
		[CLink]
		public static extern Vector3 Vector3Zero();

		// Vector with components value 1.0f
		[CLink]
		public static extern Vector3 Vector3One();

		// Add two vectors
		[CLink]
		public static extern Vector3 Vector3Add(Vector3 v1, Vector3 v2);

		// Subtract two vectors
		[CLink]
		public static extern Vector3 Vector3Subtract(Vector3 v1, Vector3 v2);

		// Multiply vector by scalar
		[CLink]
		public static extern Vector3 Vector3Multiply(Vector3 v, float scalar);

		// Multiply vector by vector
		[CLink]
		public static extern Vector3 Vector3MultiplyV(Vector3 v1, Vector3 v2);

		// Calculate two vectors cross product
		[CLink]
		public static extern Vector3 Vector3CrossProduct(Vector3 v1, Vector3 v2);

		// Calculate one vector perpendicular vector
		[CLink]
		public static extern Vector3 Vector3Perpendicular(Vector3 v);

		// Calculate vector length
		[CLink]
		public static extern float Vector3Length(Vector3 v);

		// Calculate two vectors dot product

		[CLink]
		public static extern float Vector3DotProduct(Vector3 v1, Vector3 v2);

		// Calculate distance between two vectors
		[CLink]
		public static extern float Vector3Distance(Vector3 v1, Vector3 v2);

		// Scale provided vector

		[CLink]
		public static extern Vector3 Vector3Scale(Vector3 v, float scale);

		// Negate provided vector (invert direction)
		[CLink]
		public static extern Vector3 Vector3Negate(Vector3 v);

		// Divide vector by a float value
		[CLink]
		public static extern Vector3 Vector3Divide(Vector3 v, float div);

		// Divide vector by vector
		[CLink]
		public static extern Vector3 Vector3DivideV(Vector3 v1, Vector3 v2);

		// Normalize provided vector
		[CLink]
		public static extern Vector3 Vector3Normalize(Vector3 v);

		// Orthonormalize provided vectors
		// Makes vectors normalized and orthogonal to each other
		// Gram-Schmidt function implementation
		[CLink]
		public static extern void Vector3OrthoNormalize(Vector3* v1, Vector3* v2);

		// Transforms a Vector3 by a given Matrix
		[CLink]
		public static extern Vector3 Vector3Transform(Vector3 v, Matrix mat);

		// Transform a vector by quaternion rotation
		[CLink]
		public static extern Vector3 Vector3RotateByQuaternion(Vector3 v, Quaternion q);

		// Calculate linear interpolation between two vectors
		[CLink]
		public static extern Vector3 Vector3Lerp(Vector3 v1, Vector3 v2, float amount);

		// Calculate reflected vector to normal
		[CLink]
		public static extern Vector3 Vector3Reflect(Vector3 v, Vector3 normal);

		// Return min value for each pair of components
		[CLink]
		public static extern Vector3 Vector3Min(Vector3 v1, Vector3 v2);

		// Return max value for each pair of components
		[CLink]
		public static extern Vector3 Vector3Max(Vector3 v1, Vector3 v2);

		// Compute barycenter coordinates (u, v, w) for point p with respect to triangle (a, b, c)
		// NOTE: Assumes P is on the plane of the triangle
		[CLink]
		public static extern Vector3 Vector3Barycenter(Vector3 p, Vector3 a, Vector3 b, Vector3 c);

		// Returns Vector3 as float array
		[CLink]
		public static extern float3 Vector3ToFloatV(Vector3 v);

		// Compute matrix determinant
		[CLink]
		public static extern float MatrixDeterminant(Matrix mat);

		// Returns the trace of the matrix (sum of the values along the diagonal)
		[CLink]
		public static extern float MatrixTrace(Matrix mat);

		// Transposes provided matrix
		[CLink]
		public static extern Matrix MatrixTranspose(Matrix mat);

		// Invert provided matrix
		[CLink]
		public static extern Matrix MatrixInvert(Matrix mat);

		// Normalize provided matrix
		[CLink]
		public static extern Matrix MatrixNormalize(Matrix mat);

		// Returns identity matrix
		[CLink]
		public static extern Matrix MatrixIdentity();

		// Add two matrices
		[CLink]
		public static extern Matrix MatrixAdd(Matrix left, Matrix right);

		// Subtract two matrices (left - right)
		[CLink]
		public static extern Matrix MatrixSubtract(Matrix left, Matrix right);

		// Returns translation matrix
		[CLink]
		public static extern Matrix MatrixTranslate(float x, float y, float z);

		// Create rotation matrix from axis and angle
		// NOTE: Angle should be provided in radians
		[CLink]
		public static extern Matrix MatrixRotate(Vector3 axis, float angle);

		// Returns xyz-rotation matrix (angles in radians)
		[CLink]
		public static extern Matrix MatrixRotateXYZ(Vector3 ang);

		// Returns x-rotation matrix (angle in radians)
		[CLink]
		public static extern Matrix MatrixRotateX(float angle);

		// Returns y-rotation matrix (angle in radians)
		[CLink]
		public static extern Matrix MatrixRotateY(float angle);

		// Returns z-rotation matrix (angle in radians)
		[CLink]
		public static extern Matrix MatrixRotateZ(float angle);

		// Returns scaling matrix
		[CLink]
		public static extern Matrix MatrixScale(float x, float y, float z);

		// Returns two matrix multiplication
		// NOTE: When multiplying matrices... the order matters!
		[CLink]
		public static extern Matrix MatrixMultiply(Matrix left, Matrix right);

		// Returns perspective projection matrix
		[CLink]
		public static extern Matrix MatrixFrustum(double left, double right, double bottom, double top, double near, double far);

		// Returns perspective projection matrix
		// NOTE: Angle should be provided in radians
		[CLink]
		public static extern Matrix MatrixPerspective(double fovy, double aspect, double near, double far);

		// Returns orthographic projection matrix
		[CLink]
		public static extern Matrix MatrixOrtho(double left, double right, double bottom, double top, double near, double far);

		// Returns camera look-at matrix (view matrix)
		[CLink]
		public static extern Matrix MatrixLookAt(Vector3 eye, Vector3 target, Vector3 up);

		// Returns float array of matrix data
		[CLink]
		public static extern float16 MatrixToFloatV(Matrix mat);

		// Returns identity quaternion
		[CLink]
		public static extern Quaternion QuaternionIdentity();

		// Computes the length of a quaternion
		[CLink]
		public static extern float QuaternionLength(Quaternion q);

		// Normalize provided quaternion
		[CLink]
		public static extern Quaternion QuaternionNormalize(Quaternion q);

		// Invert provided quaternion
		[CLink]
		public static extern Quaternion QuaternionInvert(Quaternion q);

		// Calculate two quaternion multiplication
		[CLink]
		public static extern Quaternion QuaternionMultiply(Quaternion q1, Quaternion q2);

		// Calculate linear interpolation between two quaternions
		[CLink]
		public static extern Quaternion QuaternionLerp(Quaternion q1, Quaternion q2, float amount);

		// Calculate slerp-optimized interpolation between two quaternions
		[CLink]
		public static extern Quaternion QuaternionNlerp(Quaternion q1, Quaternion q2, float amount);

		// Calculates spherical linear interpolation between two quaternions
		[CLink]
		public static extern Quaternion QuaternionSlerp(Quaternion q1, Quaternion q2, float amount);

		// Calculate quaternion based on the rotation from one vector to another
		[CLink]
		public static extern Quaternion QuaternionFromVector3ToVector3(Vector3 from, Vector3 to);

		// Returns a quaternion for a given rotation matrix
		[CLink]
		public static extern Quaternion QuaternionFromMatrix(Matrix mat);

		// Returns a matrix for a given quaternion
		[CLink]
		public static extern Matrix QuaternionToMatrix(Quaternion q);

		// Returns rotation quaternion for an angle and axis
		// NOTE: angle must be provided in radians
		[CLink]
		public static extern Quaternion QuaternionFromAxisAngle(Vector3 axis, float angle);

		// Returns the rotation angle and axis for a given quaternion
		[CLink]
		public static extern void QuaternionToAxisAngle(Quaternion q, Vector3* outAxis, float* outAngle);

		// Returns he quaternion equivalent to Euler angles
		[CLink]
		public static extern Quaternion QuaternionFromEuler(float roll, float pitch, float yaw);

		// Return the Euler angles equivalent to quaternion (roll, pitch, yaw)
		// NOTE: Angles are returned in a Vector3 struct in degrees
		[CLink]
		public static extern Vector3 QuaternionToEuler(Quaternion q);

		// Transform a quaternion given a transformation matrix
		[CLink]
		public static extern Quaternion QuaternionTransform(Quaternion q, Matrix mat);
	}
}
