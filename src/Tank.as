package  
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	/**
	 * ...
	 * @author Sjoerd Jakobss
	 */
	public class Tank extends BaseTank//MovieClip
	{
		//private var myTankBody:TankBody;
		//private var myTankTurret:TankTurret;
		//public var turretRotation:Number;
		
		public function Tank() 
		{
		
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		
			myTankBody = new TankBody();			//instantieren van de class
			addChild(myTankBody);
			
			myTankTurret = new TankTurret();
			addChild(myTankTurret);
		
		}
		
		private function init(e:Event):void 
		{
			stage.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			var se:ShootEvent = new ShootEvent("shoot");
			se.shooter = this;
			dispatchEvent(se);
			//dispatchEvent(new Event ("shoot"));
		}
		
		 override public function update():void
		{
			rotateBody();
			moveTank();
			super.update();
		//	rotateTurret();
		}
		/*
		private function rotateTurret():void
		{
			var dx:Number = mouseX;
			var dy:Number = mouseY;
			var r:Number = Math.atan2(dy, dx);
			var degrees:Number = r * 180 / Math.PI;
			myTankTurret.rotation = degrees;
			turretRotation = degrees;
		}*/
		private function rotateBody():void
		{
			this.rotation += Main.input.x * 5;
		}
		
		private function moveTank():void
		{
			var r:Number = this.rotation * Math.PI / 180;
			var xMove:Number = Math.cos(r);
			var yMove:Number = Math.sin(r);
			
			targetPosition.x = mouseX;
			targetPosition.y = mouseY;
			this.x += Main.input.y * xMove * 15;
			this.y += Main.input.y * yMove * 15;
		}
		override public function destroy():void
		{
			stage.removeEventListener(MouseEvent.CLICK, onClick);
			super.destroy
		}
	}

}