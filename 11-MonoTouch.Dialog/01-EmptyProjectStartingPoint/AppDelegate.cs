using System;
using System.Collections.Generic;
using System.Linq;
using MonoTouch.Foundation;
using MonoTouch.UIKit;

namespace EmptyProjectStartingPoint
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

			//----------------------------------------------------------------------
			// By default in Xamarin Template
			// Error:
			// 2014-01-28 15:08:26.894 EmptyProjectStartingPoint[44281:80b] 
			// Application windows are expected to have a root view controller at the 
			// end of application launch
			//
			// This is commented out thus error from above!
			// If you have defined a root view controller, set it here:
			// window.RootViewController = 
			//----------------------------------------------------------------------
			// Definition OF UI
			// DialogViewController : UITableViewController
			MonoTouch.Dialog.DialogViewController dialog_view_controller;
			dialog_view_controller =
				new MonoTouch.Dialog.DialogViewController 
				(
					new MonoTouch.Dialog.RootElement("RootElement1 ")
					{
						new MonoTouch.Dialog.Section ("Section 1")
							{
								new MonoTouch.Dialog.RootElement 
														(
														  "RootElement 2"
														, new MonoTouch.Dialog.RadioGroup ("RadioGroup", 2)
														)
								{
									new MonoTouch.Dialog.Section () 
									{
									  new MonoTouch.Dialog.RadioElement ("Radio Element 1", "1")
									, new MonoTouch.Dialog.RadioElement ("Radio Element 2", "2")
									, new MonoTouch.Dialog.RadioElement ("Radio Element 3", "3")
									}	
								} 
							}
					, new MonoTouch.Dialog.Section ("Section 2")
					{
						new MonoTouch.Dialog.RootElement("Root Element 3") 
						{
							new MonoTouch.Dialog.Section () 
							{
							}	
						} 
					}
					}
				);
			//----------------------------------------------------------------------
			// This is commented out in Empty Project
			// Assign UIViewController
			window.RootViewController = dialog_view_controller;
			//----------------------------------------------------------------------

			// make the window visible
			window.MakeKeyAndVisible ();
			
			return true;
		}
	}
}

