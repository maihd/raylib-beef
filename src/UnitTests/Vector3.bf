namespace Raylib.UnitTests;

using System;
using Raylib;

static
{
    [Test]
    static void TestVector3Add()
    {
		let a = Vector3(1.0f, 2.0f, 3.0f);
		let b = Vector3(4.0f, 5.0f, 6.0f);

		let c = a + b;
		Test.Assert(c.x == 5.0f && c.y == 7.0f && c.z == 9.0f);
    }

    [Test]
    static void TestVector3Sub()
    {
		let a = Vector3(1.0f, 2.0f, 3.0f);
		let b = Vector3(4.0f, 5.0f, 6.0f);

		let c = a - b;
		Test.Assert(c.x == -3.0f && c.y == -3.0f && c.z == -3.0f);
    }

    [Test]
    static void TestVector3Mul()
    {
		let a = Vector3(1.0f, 2.0f, 3.0f);
		let b = Vector3(4.0f, 5.0f, 6.0f);

		let c = a * b;
		Test.Assert(c.x == 4.0f && c.y == 10.0f && c.z == 18.0f);
    }

    [Test]
    static void TestVector3Div()
    {
		let a = Vector3(1.0f, 2.0f, 3.0f);
		let b = Vector3(4.0f, 5.0f, 6.0f);

		let c = a / b;
		Test.Assert(c.x == 0.25f && c.y == 0.4f && c.z == 0.5f);
    }
}