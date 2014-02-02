using System;
using System.Drawing;
using MonoTouch.Foundation;
using MonoTouch.UIKit;

namespace UniversalXIBSingleView
{
	public partial class UniversalXIBSingleViewViewController : UIViewController
	{
		static bool UserInterfaceIdiomIsPhone
		{
			get
			{
				return UIDevice.CurrentDevice.UserInterfaceIdiom == UIUserInterfaceIdiom.Phone;
			}
		}

		public UniversalXIBSingleViewViewController ()
			: base (UserInterfaceIdiomIsPhone ? "UniversalXIBSingleViewViewController_iPhone" : "UniversalXIBSingleViewViewController_iPad", null)
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

