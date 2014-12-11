package  
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author sjoerd Jakobs
	 */
	public class Background extends Sprite
	{
		[Embed(source="../lib/background.jpg")]
		private var BackgroundImage:Class;
		
		private var bgImage:Bitmap;
		
		public function Background() 
		{
			//constructor
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			//eventlistener maken
			this.scaleX = 1;
			this.scaleY = 1;
			
			
			
		}
		private function init(e:Event = null):void
		{
			bgImage = new BackgroundImage();
			addChild (bgImage);
		}
	}

}