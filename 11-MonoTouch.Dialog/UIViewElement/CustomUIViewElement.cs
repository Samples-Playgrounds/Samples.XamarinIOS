using System;

namespace UIViewElement
{
	public partial class CustomUIViewElement : UIViewElement
	{
     	public CustomUIViewElement (String caption, Action Handler)
                : base ("", null, false)
		{
			System.Drawing.RectangleF rec = new System.Drawing.RectangleF (0, 0, 300, 50);
			MonoTouch.UIKit.UIView container = new MonoTouch.UIKit.UIView (rec);
				
			System.Drawing.SizeF size = 
				new MonoTouch.Foundation.NSString(caption)
						.StringSize 
							(
							  MonoTouch.UIKit.UIFont.SystemFontOfSize (18)
							, MonoTouch.UIKit.UIScreen.MainScreen.Bounds.Width
							, MonoTouch.UIKit.UILineBreakMode.TailTruncation
							);
			MonoTouch.Dialog.GlassButton button = 
					new MonoTouch.Dialog.GlassButton 
							(
							  new System.Drawing.RectangleF 
													(
													  (rec.Width - 8) / 2 - (size.Width + 20) / 2
					                                , 4
													, size.Width + 20
													, rec.Height - 8
													)
							)
							{
								Font = MonoTouch.UIKit.UIFont.SystemFontOfSize (18),
								NormalColor = new MonoTouch.UIKit.UIColor (0.471f, 0.553f, 0.659f, 1.0f)
							};
			button.Tapped += delegate
			{
				Handler.Invoke ();
			};
			button.SetTitle (caption, MonoTouch.UIKit.UIControlState.Normal);
			container.AddSubview (button);
			View = container;
		}
	}
}

