using System;

using UIKit;

namespace XIBNIB
{
	public partial class ViewControllerA : UIViewController
	{
		public ViewControllerA () : base ("ViewControllerA", null)
		{
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			// Perform any additional setup after loading the view, typically from a nib.

			this.Title = "Viewcontroller A";
			this.View.BackgroundColor = UIColor.Red;


		}

		public override void DidReceiveMemoryWarning ()
		{
			base.DidReceiveMemoryWarning ();
			// Release any cached data, images, etc that aren't in use.
		}

		partial void navigateToViewcontrollerB (UIButton sender)
		{
			var viewcontrollerB = new ViewControllerB ();
			this.NavigationController.PushViewController(viewcontrollerB, true);
		}
	}
}


