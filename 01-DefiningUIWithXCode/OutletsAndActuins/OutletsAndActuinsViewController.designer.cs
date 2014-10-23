// WARNING
//
// This file has been generated automatically by Xamarin Studio to store outlets and
// actions made in the UI designer. If it is removed, they will be lost.
// Manual changes to this file may not be handled correctly.
//
using MonoTouch.Foundation;
using System.CodeDom.Compiler;

namespace OutletsAndActuins
{
	[Register ("OutletsAndActuinsViewController")]
	partial class OutletsAndActuinsViewController
	{
		[Outlet]
		MonoTouch.UIKit.UIButton buttonAsOutlet { get; set; }

		[Action ("buttonAsAction:")]
		partial void buttonAsAction (MonoTouch.Foundation.NSObject sender);
		
		void ReleaseDesignerOutlets ()
		{
			if (buttonAsOutlet != null) {
				buttonAsOutlet.Dispose ();
				buttonAsOutlet = null;
			}
		}
	}
}
