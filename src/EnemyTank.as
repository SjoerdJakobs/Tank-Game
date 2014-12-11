package  
{
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	/**
	 * ...
	 * @author sjoerd Jakobs
	 */
	public class EnemyTank extends BaseTank
	{
		
		private var shootTimer:Timer;
		public function EnemyTank() 
		{
			shootTimer = new Timer(1000 + Math.random()*1000);
			shootTimer.addEventListener(TimerEvent.TIMER, shoot);
			shootTimer.start();
			
			
			myTankBody = new ETankBody();			//instantieren van de class
			addChild(myTankBody);
			
			myTankTurret = new ETankTurret();
			addChild(myTankTurret);
		}
		
		private function shoot(e:TimerEvent):void 
		{
			var se:ShootEvent = new ShootEvent("shoot");
			se.shooter = this;
			dispatchEvent(se);
		}
		override public function update():void
		{
			eRotation();
			super.update();
		}
		private function eRotation():void
		{
			if (Main.myTank != null)
			{
				targetPosition.x = Main.myTank.x - this.x;
				targetPosition.y = Main.myTank.y - this.y;
			}
		}
		override public function destroy():void
		{
			shootTimer.removeEventListener(TimerEvent.TIMER, shoot);
			shootTimer.stop();
			shootTimer = null;
			super.destroy();
		}
	}

}