using System;
using System.Collections.Generic;
using System.Linq;
using MonoTouch.Foundation;
using MonoTouch.UIKit;

namespace XibLessProgrammaticallyNavigationController
{
	// The UIApplicationDelegate for the application. This class is responsible for launching the
	// User Interface of the application, as well as listening (and optionally responding) to
	// application events from iOS.
	[Register ("AppDelegate")]
	public partial class AppDelegate : UIApplicationDelegate
	{
		// class-level declarations
		UIWindow window;
		//
		// This method is invoked when the application has loaded and is ready to run. In this
		// method you should instantiate the window, load the UI into it and then make the window
		// visible.
		//
		// You have 17 seconds to return from this method, or iOS will terminate your application.
		//
		public override bool FinishedLaunching (UIApplication app, NSDictionary options)
		{
			// create a new window instance based on the screen size
			window = new UIWindow (UIScreen.MainScreen.Bounds);
			
			
			//----------------------------------------------------------------------------------------------------------
			// If you have defined a root view controller, set it here:
			// window.RootViewController = myViewController;
			
			UINavigationController root_navigation_controller = null;
			root_navigation_controller = new UINavigationController();
			root_navigation_controller.NavigationItem.HidesBackButton = false;
			root_navigation_controller.NavigationBarHidden = false;  // default

			UIBarButtonItem left_button = new UIBarButtonItem
												(
												  "left"								
												, UIBarButtonItemStyle.Done
												, null
												);
        	left_button.Clicked += 
					(o, e) => 
					{
            			root_navigation_controller.PopViewControllerAnimated(true);
        			};
	        root_navigation_controller.NavigationItem
											.SetLeftBarButtonItem
													(
													  left_button
													, true
													);   			
			

			UITableViewController tableview_controller_2nd_screen = null;
			tableview_controller_2nd_screen =  new UITableViewController();

			UIBarButtonItem right_button = new UIBarButtonItem
												(
												  "right"								
												, UIBarButtonItemStyle.Plain
												, null
												);
			right_button.Clicked += 
					(o, e) => 
					{
						root_navigation_controller.PushViewController
													(
													  tableview_controller_2nd_screen
													, true
													);
        			};
			root_navigation_controller.NavigationItem
											.SetRightBarButtonItem
												(
												  right_button
												, true
												);
			

			// UIViewController is usually not used
			// Use derived classes
			UIViewController viewController = new UIViewController();
   			root_navigation_controller.PushViewController(viewController,false);

			
			window.RootViewController = root_navigation_controller;
			//----------------------------------------------------------------------------------------------------------
			
			// make the window visible
			window.MakeKeyAndVisible ();
			
			return true;
		}
	}
}

