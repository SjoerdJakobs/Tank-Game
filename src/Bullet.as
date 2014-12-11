package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author sjoerd Jakobs
	 */
	public class Bullet extends MovieClip
	{
		private var xMove:Number;
		private var yMove:Number;
		public function Bullet(xpos:Number, ypos:Number, rot:Number) :void
		{
			
			this.rotation = rot;
			addChild(new bulletArt());
			
			
			var r:Number = this.rotation * Math.PI / 180;
			xMove = Math.cos(r);
			yMove = Math.sin(r);
			
			this.x = xpos + xMove * 105;
			this.y = ypos + yMove * 105;
		}
		public function update():void
		{
			this.x += xMove * 17;
			this.y += yMove * 17;
		}
		
	}

}