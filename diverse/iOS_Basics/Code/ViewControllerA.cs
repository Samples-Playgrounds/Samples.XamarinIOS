using System;

using UIKit;

namespace Code
{
	public partial class ViewControllerA : UIViewController
	{
		// This is automatically created when ViewController is chosen from Add New File
		// with XIB. As we don't want that for our "code" only sample, this must be removed in oreder to allow proper init.
		// public ViewControllerB () : base ("ViewControllerB", null)
		// {
		// }

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			// Perform any additional setup after loading the view, typically from a nib.

			this.Title = "Viewcontroller A";
			this.View.BackgroundColor = UIColor.Red;

			// Create a new tap gesture
			UITapGestureRecognizer tapGesture = null;

			// Report touch
			Action action = () => {
				var viewcontrollerB = new ViewControllerB();
				this.NavigationController.PushViewController(viewcontrollerB, true);
			};

			tapGesture = new UITapGestureRecognizer(action);

			// Configure it
			tapGesture.NumberOfTapsRequired = 2;


			this.View.AddGestureRecognizer (tapGesture);

		}

		public override void DidReceiveMemoryWarning ()
		{
			base.DidReceiveMemoryWarning ();
			// Release any cached data, images, etc that aren't in use.
		}
	}
}


