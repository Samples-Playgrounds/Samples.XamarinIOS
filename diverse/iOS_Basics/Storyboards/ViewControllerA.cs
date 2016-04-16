using System;

using UIKit;

namespace Storyboards
{
	public partial class ViewControllerA : UIViewController
	{
		public ViewControllerA (IntPtr handle) : base (handle)
		{
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			// Perform any additional setup after loading the view, typically from a nib.
		}

		public override void DidReceiveMemoryWarning ()
		{
			base.DidReceiveMemoryWarning ();
			// Release any cached data, images, etc that aren't in use.
		}

		partial void navigateToViewControllerBOnStoryboardB (UIButton sender)
		{
			// This assumes:
			// - that you have navigation controller, you can wrap your view controller in navigation controller in storyboard
			//		
			// 
			// - that the view controller B is initial view controller in storyboard B,
			// 		you can do that by selecting on a view controller and mark it 'initialviewcontroller' (Properties -> Widget )
			// 		to be sure that this is the case, view controller will have arrow pointing to it from the left
			// 
			// - in case you want some random view controller from storyboard, 
			//		you will need to assign an identifier to it (Properties -> Identity -> StoryboardID)
			//		and call storyboardB.InstantiateViewController("ViewControllerB")

			var storyboardB = UIStoryboard.FromName("StoryboardB", null);
			var viewcontrollerB = storyboardB.InstantiateInitialViewController() as ViewControllerB;
			this.NavigationController.PushViewController(viewcontrollerB, true);

		}
	}
}


