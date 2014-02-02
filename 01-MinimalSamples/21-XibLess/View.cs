using System;
using MonoTouch.UIKit;
using System.Drawing;

namespace XIBless
{
	public class View : UIView
	{
		public View (RectangleF frame) : base()
		{
			Frame = frame;

			this.BackgroundColor = UIColor.Blue;
			
			//------------------------------------------------------------------------------
			UIButton button01 = new UIButton(UIButtonType.RoundedRect);
			button01.Frame = new RectangleF
				(
				  new PointF(20, 40)
				, new SizeF(100,40)	
				);
			button01.BackgroundColor = UIColor.Yellow;
			button01.SetTitle("Button", UIControlState.Normal);
			button01.SetTitleColor(UIColor.Green, UIControlState.Normal);
			this.AddSubview(button01);
			//------------------------------------------------------------------------------
			
			//------------------------------------------------------------------------------
			UILabel label01 = new UILabel();
			label01.Frame = new RectangleF
				(
				  new PointF(20, 90)
				, new SizeF(100,40)	
				);
			label01.BackgroundColor = UIColor.Yellow;
			label01.TextColor = UIColor.Green;
			label01.Text = "Label";
			
			this.AddSubview(label01);
			//------------------------------------------------------------------------------
			return;
		}
	}
}

