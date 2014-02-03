using System;
using System.Drawing;
using MonoTouch.Foundation;
using MonoTouch.SpriteKit;
using MonoTouch.UIKit;

namespace UniversalSpriteKit
{
	public class MyScene : SKScene
	{
		public MyScene (SizeF size) : base (size)
		{
			// Setup your scene here
			BackgroundColor = new UIColor (0.15f, 0.15f, 0.3f, 1.0f);

			var myLabel = new SKLabelNode ("Chalkduster") {
				Text = "Hello, World!",
				FontSize = 30,
			};

			myLabel.Position = new PointF (Frame.X + Frame.Width / 2, Frame.Y + Frame.Height / 2);

			AddChild (myLabel);
		}

		public override void TouchesBegan (NSSet touches, UIEvent evt)
		{
			// Called when a touch begins
			foreach (var touch in touches)
			{
				var location = ((UITouch)touch).LocationInNode (this);
				var sprite = new SKSpriteNode ("Spaceship");
				sprite.Position = location;

				var action = SKAction.RotateByAngle ((float)Math.PI, 1.0);
				sprite.RunAction (SKAction.RepeatActionForever (action));

				AddChild (sprite);
			}
		}

		public override void Update (double currentTime)
		{
			// Run before each frame is rendered
			base.Update (currentTime);
		}
	}
}
