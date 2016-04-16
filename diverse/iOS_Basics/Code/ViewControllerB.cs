using System;

using UIKit;

namespace Code
{
	public partial class ViewControllerB : UIViewController
	{

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			// Perform any additional setup after loading the view, typically from a nib.

			this.Title = "Viewcontroller B";
			this.View.BackgroundColor = UIColor.Green;
		}

		public override void DidReceiveMemoryWarning ()
		{
			base.DidReceiveMemoryWarning ();
			// Release any cached data, images, etc that aren't in use.
		}
	}
}


