using System;
using System.Collections.Generic;
using System.Linq;
using MonoTouch.Foundation;
using MonoTouch.UIKit;

namespace ProgramaticallyDefineUIControllerNotUsed
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
			
			//------------------------------------------------------------------------
			// If you have defined a root view controller, set it here:
			// window.RootViewController = myViewController;
			UILabel label_custom = 
					// CreateCustomLabel01()
					CreateCustomLabel02()
					;
			UIButton button_custom = CreateCustomButton ();
			window.AddSubview(label_custom);
			window.AddSubview(button_custom);
			
			//------------------------------------------------------------------------

			// make the window visible
			window.MakeKeyAndVisible ();
			
			return true;
		}

		void ChangeUI (object sender, EventArgs e)
		{
			foreach (UIView view in window.Subviews)
			{
				view.RemoveFromSuperview ();
			}
			
			Random rnd_generator = new Random (DateTime.Now.Millisecond);
			int rnd = rnd_generator.Next (0, 2);
			int mod = rnd % 2;
			Console.WriteLine("rnd = {0}, mod = {1}", rnd, mod);
			switch (mod)
			{
				case 0:
					{
						UILabel label = CreateCustomLabel01 ();
						window.AddSubview (label);
					}
					break;
				case 1:
					{
						UILabel label = CreateCustomLabel02 ();
						window.AddSubview (label);
					}
					break;
				default:
					break;
			}
			
			window.AddSubview(CreateCustomButton());
			
			return;
		}

		UIButton CreateCustomButton ()
		{
			UIButton button_custom = new UIButton ();
			button_custom.BackgroundColor = UIColor.White;
			button_custom.SetTitle ("Just keep on clicking!", UIControlState.Normal);
			button_custom.SetTitleColor (UIColor.Blue, UIControlState.Normal);
			int button_width = 300;
			button_custom.Frame = new System.Drawing.RectangleF 
														(
					   									  window.Frame.Width - button_width	// x
														, 10								// y
														, button_width						// w
														, 20								// h
														);
			button_custom.TouchUpInside += ChangeUI;
			
			return button_custom;
		}
	
		UILabel CreateCustomLabel01 ()
		{
			UILabel label_custom = new UILabel ();
			label_custom.BackgroundColor = UIColor.Yellow;
			label_custom.Text = "Programmatically creating UI sample!";
			label_custom.Frame = window.Frame;

			return label_custom;
		}
		
		UILabel CreateCustomLabel02 ()
		{
			UILabel label_custom = new UILabel ();
			label_custom.BackgroundColor = UIColor.Yellow;
			label_custom.Text = "Programmatically creating UI sample!";
			label_custom.TextColor = UIColor.Blue;
			label_custom.Frame = new System.Drawing.RectangleF
											(
											  50						// x
											, 100						// y
											, 150						// w
											, 300						// h
											);

			return label_custom;
		}
	}
}

