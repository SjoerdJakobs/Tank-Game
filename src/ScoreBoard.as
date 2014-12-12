package  
{
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author sjoerd Jakobs
	 */
	public class ScoreBoard extends TextField
	{
		private var _score:Number = 0;
		[Embed(source = "../font/Scream Again.ttf",fontName="myFont",embedAsCFF="false")]
		private var font:Class;
		
		public function set score(s:Number):void
		{ 
			_score = s;
			this.text = "score : " + _score;
		}
		public function get score():Number
		{
			return _score;
		}
		public function ScoreBoard() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			/*this.setTextFormat(new TextFormat(""))*/
			

		}
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			this.defaultTextFormat = new TextFormat("myFont",30,0xFF0000,true );
			this.width = stage.stageWidth;
			this.text = "score : " + score;
		
			
			this.embedFonts = true;
		}
		
	}

}