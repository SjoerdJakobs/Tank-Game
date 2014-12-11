package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author sjoerd Jakobs
	 */
	public class Crate extends MovieClip
	{
		private var crateArt:MovieClip
		public var lives:int = 6;
		public function Crate() 
		{
			crateArt = new CrateArt();
			addChild(crateArt);
		}
		
	}

}