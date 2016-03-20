using System;

#if __UNIFIED__
using Foundation;
#else
using MonoTouch.Foundation;
#endif

namespace Tests
{
	public class TestClassPreprocessorDefines
	{
		public TestClassPreprocessorDefines ()
		{
			#if __UNIFIED__
			nint counter = 0;
			#else
			int counter = 0;
			#endif

		}
	}
}

