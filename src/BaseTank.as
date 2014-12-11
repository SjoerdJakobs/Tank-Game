package  
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	/**
	 * ...
	 * @author sjoerd Jakobs
	 */
	public class BaseTank extends MovieClip
	{
		protected var myTankBody:MovieClip;
		protected var myTankTurret:MovieClip;
		public var turretRotation:Number;
		public var targetPosition:Point;
		
		public function BaseTank() 
		{
			targetPosition = new Point();
		}
		public function update():void
		{
			rotateTurret();
		}
		private function rotateTurret():void
		{
			var dx:Number = targetPosition.x;
			var dy:Number = targetPosition.y;
			var r:Number = Math.atan2(dy, dx);
			var degrees:Number = r * 180 / Math.PI;
			myTankTurret.rotation = degrees;
			turretRotation = degrees;
		}
		/*private function rotateBody():void
		{
			this.rotation += Main.input.x * 5;
		}*/
		//wil geen draaiende enemytank door mijn toetsenbord :p
	}

}