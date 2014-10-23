
using System;
using System.Drawing;

//-----------------------------------------------
// Defined as empty namespaces
using MonoTouch.Foundation;
using MonoTouch.UIKit;
//-----------------------------------------------

//-----------------------------------------------
// Defined as empty namespaces
using UIKit=MonoTouch.UIKit;

using 	nint=System.Int32;
using UIKit;

namespace Tests
{
	public partial class UniversalViewController : UIViewController
	{
		int 	some_int;
		nint 	some_nint;

		static bool UserInterfaceIdiomIsPhone
		{
			get
			{
				return UIDevice.CurrentDevice.UserInterfaceIdiom == UIUserInterfaceIdiom.Phone;
			}
		}

		public UniversalViewController ()
			: base (UserInterfaceIdiomIsPhone ? "UniversalViewController_iPhone" : "UniversalViewController_iPad", null)
		{
		}

		public override void DidReceiveMemoryWarning ()
		{
			// Releases the view if it doesn't have a superview.
			base.DidReceiveMemoryWarning ();
			
			// Release any cached data, images, etc that aren't in use.
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			
			// Perform any additional setup after loading the view, typically from a nib.
		}
	}
}

