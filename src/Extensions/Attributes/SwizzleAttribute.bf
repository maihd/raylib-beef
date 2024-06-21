namespace Raylib;

using System;
using System.Reflection;

public struct SwizzleAttribute : this(int Size, bool HasColor = false, bool HasVector = true), Attribute, IOnTypeInit
{
    private static readonly let VectorTypeNames = String[?]("float", "Vector2", "Vector3", "Vector4");
	private static readonly let ColorTypeNames = String[?]("int", null, "Color", "Color");

    private static readonly let xyzw = String[?]("x", "y", "z", "w");
    private static readonly let rgba = String[?]("r", "g", "b", "a");

    private Span<String> fields    = null;
    private Span<String> typeNames = null;

	[Comptime]
	public void OnTypeInit(Type type, Self* prev) mut
	{
		if (Size < 2 || Size > 4)
		{
			Runtime.FatalError("Only vector with size in [2, 4] are support swizzle.");
		}

        fields        = HasVector ? xyzw            : (HasColor ? rgba           : xyzw           );
        typeNames     = HasVector ? VectorTypeNames : (HasColor ? ColorTypeNames : VectorTypeNames);

        if (HasVector)
        {
            GenerateSwizzles(type, xyzw);
        }
		
        if (HasColor)
        {
            GenerateSwizzles(type, rgba, !HasVector);
        }
	}
	
	[Comptime]
	private void GenerateSwizzles(Type type, Span<String> keys, bool skep1 = true)
	{
        if (!skep1)
        {
            for (let i in 0..<Size)
            {
                GenerateSwizzleProperty(type, keys, int[?](i));
            }
        }

		for (let i in 0..<Size)
		{
			for (let j in 0..<Size)
			{
				GenerateSwizzleProperty(type, keys, int[?](i, j));
			}
		}

		if (Size < 3)
		{
			return;
		}

		for (let i in 0..<Size)
		{
			for (let j in 0..<Size)
			{
				for (let k in 0..<Size)
				{
					GenerateSwizzleProperty(type, keys, int[?](i, j, k));
				}
			}
		}

		if (Size < 4)
		{
			return;
		}


		for (let i in 0..<Size)
		{
			for (let j in 0..<Size)
			{
				for (let k in 0..<Size)
				{
					for (let l in 0..<Size)
					{
						GenerateSwizzleProperty(type, keys, int[?](i, j, k, l));
					}
				}
			}
		}
	}

	[Comptime]
	private void GenerateSwizzleProperty(Type type, Span<String> keys, Span<int> swizzles)
	{
		let code = scope String();
		let isReadonly = HasDuplicate(swizzles);

		let typeName = typeNames[swizzles.Length - 1];
        if (typeName == null)
        {
            return;
        }

		let propertyName = scope String();
		for (let i in swizzles)
		{
			propertyName.Append(keys[i]);
		}

		code.Append(scope $"public {typeName} {propertyName} ");
		code.Append("{ get => .(");
		
        for (let i < swizzles.Length)
        {
        	code.Append(fields[swizzles[i]]);
        	if (i < swizzles.Length - 1)
        	{
        		code.Append(", ");
        	}
        }

		code.Append("); ");

		if (!isReadonly)
		{
			code.Append("set mut { ");

            if (swizzles.Length == 1)
            {
                code.Append(scope $"{fields[swizzles[0]]} = value; ");
            }
            else
            {
    			for (let i < swizzles.Length)
    			{
    				code.Append(scope $"{fields[swizzles[i]]} = value.{fields[i]}; ");
    			}
            }

			code.Append("} ");
		}

		code.Append("}\n");

		Compiler.EmitTypeBody(type, code);
	}

	[Comptime]
	private bool HasDuplicate(Span<int> array)
	{
		for (let i < array.Length)
		{
			for (let j in (i + 1)..<array.Length)
			{
				if (array[i] == array[j])
				{
					return true;
				}
			}
		}

		return false;
	}
}