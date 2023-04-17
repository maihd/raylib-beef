namespace Raylib.UnitTests;

using System;
using Raylib;

static
{
    [Test]
    static void TestVector2Add()
    {
		let a = Vector2(1.0f, 2.0f);
		let b = Vector2(3.0f, 4.0f);

		let c = a + b;
		Test.Assert(c.x == 4.0f && c.y == 6.0f);
    }

    [Test]
    static void TestVector2Sub()
    {
		let a = Vector2(1.0f, 2.0f);
		let b = Vector2(3.0f, 4.0f);

		let c = a - b;
		Test.Assert(c.x == -2.0f && c.y == -2.0f);
    }

    [Test]
    static void TestVector2Mul()
    {
		let a = Vector2(1.0f, 2.0f);
		let b = Vector2(3.0f, 4.0f);

		let c = a * b;
		Test.Assert(c.x == 3.0f && c.y == 8.0f);
    }

    [Test]
    static void TestVector2Div()
    {
		let a = Vector2(1.0f, 2.0f);
		let b = Vector2(3.0f, 4.0f);

		let c = a / b;
		Test.Assert(c.x == 1.0f / 3.0f && c.y == 0.5f);
    }
}