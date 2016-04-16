using System;

using UIKit;

namespace XIBNIB
{
	public partial class ViewControllerB : UIViewController
	{
		public ViewControllerB () : base ("ViewControllerB", null)
		{
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			// Perform any additional setup after loading the view, typically from a nib.

			this.Title = "Viewcontroller B";
		}

		public override void DidReceiveMemoryWarning ()
		{
			base.DidReceiveMemoryWarning ();
			// Release any cached data, images, etc that aren't in use.
		}
	}
}


