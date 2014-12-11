package  
{
	import flash.events.Event;
	/**
	 * ...
	 * @author sjoerd Jakobs
	 */
	public class EnemyTank extends BaseTank
	{
		
		public function EnemyTank() 
		{
			myTankBody = new ETankBody();			//instantieren van de class
			addChild(myTankBody);
			
			myTankTurret = new ETankTurret();
			addChild(myTankTurret);
		}
		override public function update():void
		{
			eRotation();
			super.update();
		}
		private function eRotation():void
		{
			targetPosition.x = Main.myTank.x - this.x;
			targetPosition.y = Main.myTank.y - this.y;
		}
	}

}