using System;

namespace OwnerDrawnElement
{
	public partial class CustomOwnerDrawnElement : MonoTouch.Dialog.OwnerDrawnElement
	{
		public CustomOwnerDrawnElement (string text) 
			: 
			base(MonoTouch.UIKit.UITableViewCellStyle.Default, "CustomOwnerDrawnElement")
		{
			this.Text = text;
		}

		public string Text
		{
			get;set;    
		}

		public override void Draw 
								(
								  System.Drawing.RectangleF bounds
								, MonoTouch.CoreGraphics.CGContext context
								, MonoTouch.UIKit.UIView view
								)
		{
			MonoTouch.UIKit.UIColor.Red.SetFill();
			context.FillRect(bounds);

			MonoTouch.UIKit.UIColor.Blue.SetColor();   
			view.DrawString
					(
					  this.Text
					, new System.Drawing.RectangleF
											(
											  10  					// x
											, 15					// y
											, bounds.Width - 20		// width
											, bounds.Height - 30	// height
											)
					, MonoTouch.UIKit.UIFont.BoldSystemFontOfSize(14.0f)
					, MonoTouch.UIKit.UILineBreakMode.TailTruncation
					);
			
			MonoTouch.UIKit.UIColor.Green.SetColor();   
			view.DrawString
					(
					  this.Text
					, new System.Drawing.RectangleF
											(
											  10  					// x
											, 45					// y
											, bounds.Width - 20		// width
											, bounds.Height - 30	// height
											)
					, MonoTouch.UIKit.UIFont.BoldSystemFontOfSize(14.0f)
					, MonoTouch.UIKit.UILineBreakMode.TailTruncation
					);

			return;
		}

		public override float Height (System.Drawing.RectangleF bounds)
		{
			return 150.0f;
		}
	}}

