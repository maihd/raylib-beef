namespace Raylib.UnitTests;

using System;

static
{
	[Test]
	static void TestVector4Add()
	{
		let a = Vector4(1.0f, 2.0f, 3.0f, 4.0f);
		let b = Vector4(5.0f, 6.0f, 7.0f, 8.0f);

		let c = a + b;
		Test.Assert(c.x == 6.0f && c.y == 8.0f && c.z == 10.0f && c.w == 12.0f);
	}

	[Test]
	static void TestVector4Sub()
	{
		let a = Vector4(1.0f, 2.0f, 3.0f, 4.0f);
		let b = Vector4(5.0f, 6.0f, 7.0f, 8.0f);

		let c = a - b;
		Test.Assert(c.x == -4.0f && c.y == -4.0f && c.z == -4.0f && c.w == -4.0f);
	}

	[Test]
	static void TestVector4Mul()
	{
		let a = Vector4(1.0f, 2.0f, 3.0f, 4.0f);
		let b = Vector4(5.0f, 6.0f, 7.0f, 8.0f);

		let c = a * b;
		Test.Assert(c.x == 5.0f && c.y == 12.0f && c.z == 21.0f && c.w == 32.0f);
	}

	[Test]
	static void TestVector4Div()
	{
		let a = Vector4(1.0f, 2.0f, 3.0f, 4.0f);
		let b = Vector4(5.0f, 6.0f, 7.0f, 8.0f);

		let c = a / b;
		Test.Assert(c.x == 0.2f && c.y == 1.0f / 3.0f && c.z == 3.0f / 7.0f && c.w == 0.5f);
	}
}