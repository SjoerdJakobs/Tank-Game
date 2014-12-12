package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	//import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author sjoerd Jakobs
	 */
	public class Main extends Sprite 
	{
		private var enemies:Vector.<EnemyTank>;
		private var crossHair:CrossHair;
		private var background:Background;
		public static var myTank:Tank;
		public static var input:Point = new Point();
		private var bullets:Vector.<Bullet>;//:Array;
		private var scoreboard:ScoreBoard;
		
		private var crates:Vector.<Crate>;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			background = new Background();
			addChildAt(background, 0);
			background.x = stage.stageWidth * 0;
			background.y = stage.stageHeight * 0;
			
			scoreboard = new ScoreBoard();
			addChild (scoreboard);
			
			bullets = new Vector.<Bullet>();//Array();
			
			myTank = new Tank();
			addChild(myTank);
			myTank.x = stage.stageWidth * 0.5;
			myTank.y = stage.stageHeight * 0.5;
			
			myTank.scaleX = 0.5;
			myTank.scaleY = 0.5;
			
			myTank.addEventListener("shoot", createBullet);
			
			enemies = new Vector.<EnemyTank>();
			for (var i:int = 0; i < 4; i++) 
			{
				var enemy:EnemyTank = new EnemyTank();
				enemies.push(enemy);
				addChild(enemy);
				enemy.x = Math.random() * 1870;
				enemy.y = 100 + (200*i);
				enemy.scaleX = 0.40;
				enemy.scaleY = 0.40;
				enemy.addEventListener("shoot", createBullet);
			}
			
			crates = new Vector.<Crate>();
			createCrates();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			addEventListener(Event.ENTER_FRAME, loop);
			//stage.addEventListener(MouseEvent.CLICK, onClick);
			crossHair = new CrossHair();
			addChild(crossHair);
		}
		/*
		private function onClick(e:MouseEvent):void 
		{
			input.y = -0.3;	
		}
		*///worth a try
		private function createCrates():void 
		{
			for (var i:int = 0; i < 9; i++)
			{
				var crate:Crate = new Crate();
				crates.push(crate);
				addChildAt(crate, 1);
				crate.x = (crate.width/2) + (Math.random() *stage.stageWidth - crate.width);
				crate.y = (crate.height/2) + (Math.random() *stage.stageHeight - crate.height);
				crate.scaleX = 0.5;
				crate.scaleY = 0.5;
			}
		}
		private function createBullet(e:ShootEvent):void
		{
			var bullet:Bullet = new Bullet(e.shooter.x, e.shooter.y, e.shooter.rotation + e.shooter.turretRotation);
			bullets.push(bullet);
			addChildAt(bullet, 1);
			bullet.scaleX = 0.5;
			bullet.scaleY = 0.5;
			/*
			bullets.push(new bullet());
			addChild(bullet[bullets.length-1]);
			*/
		}
		private function loop(e:Event):void
		{
			for (var i : int = 0; i < enemies.length; i++) {
				enemies[i].update();
			}
			/*if (myTank.lives > 0 )
			{
				myTank.update();
			}*/  //maybe
			myTank.update();
			while (crates[j].hitTestPoint(myTank.x, myTank.y - myTank.height, true))
			{
				myTank.y --;
				myTank.x --;//doest fuking work yet >_< (hittest om niet door de kisten te kunnen rijden
			}
			
			var lenghth:int = enemies.length;
			
			for (var i:int = 0; i < bullets.length; i++)
			{
				var toRemove:Boolean = false;
				//var destroy2:Boolean = false; maybe
				var missedAll:Boolean = true;
				
				bullets[i].update();
				for (var j:int = 0; j < crates.length; j++)
				{
					if (crates[j].hitTestPoint(bullets[i].x, bullets[i].y, true))
					{
						toRemove = true;
						
						crates[j].lives--;
						if (crates[j].lives <= 0)
						{
							removeChild(crates[j]);
							crates.splice(j, 1);
						}
					}
				}
				
				for (var k:int = 0; k < enemies.length; k++ )
				{
					if (enemies[k].hitTestPoint(bullets[i].x, bullets[i].y, true))
					{
						toRemove = true;
						missedAll = false;
						scoreboard.score += 20;
						enemies[k].lives--;
						if (enemies[k].lives <= 0 )
						{
							scoreboard.score += 100;
							enemies[k].destroy();
							removeChild(enemies[k]);
							enemies.splice(k, 1);
						}
						
					}
				}
				if (myTank.hitTestPoint(bullets[i].x, bullets[i].y, true))
				{
					toRemove = true;
					myTank.lives--;
						if (myTank.lives <= 0 )
						{
							//destroy2 = true; maybe?
							myTank.destroy();
							removeChild(myTank);
							myTank = null;
							break;
						}
				}
				if (bullets[i].x > stage.stageWidth ||
				bullets[i].x < 0 ||
				bullets[i].y >stage.stageHeight ||
				bullets[i].y < 0)
				{
					toRemove = true;
					//nog niet gedaan met klas
				}
				if (missedAll)
				{
					scoreboard.score += 0;
				}
				if (toRemove)
				{
					removeChild(bullets[i]);
					bullets.splice(i, 1);
				}
				/*if (destroy2)
				{
					stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
					stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
					removeEventListener(Event.ENTER_FRAME, loop);
				}*/ //maybe?
			}
		}
		private function onKeyUp(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.D || e.keyCode == Keyboard.A )
			{
				input.x = 0;
			}
			if (e.keyCode == Keyboard.S || e.keyCode == Keyboard.W )
			{
				input.y = 0;
			}
			if (e.keyCode == Keyboard.RIGHT || e.keyCode == Keyboard.LEFT )
			{
				input.x = 0;
			}
			if (e.keyCode == Keyboard.DOWN || e.keyCode == Keyboard.UP )
			{
				input.y = 0;
			}
		}
		private function onKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == Keyboard.D )
			{
				input.x = 0.6;			
			}
			if (e.keyCode == Keyboard.A)
			{
				input.x = -0.6;
			}
			if (e.keyCode == Keyboard.S)
			{
				input.y = -0.3;
			}
			if (e.keyCode == Keyboard.W)
			{
				input.y = 0.6;
			}
			if (e.keyCode == Keyboard.RIGHT)
			{
				input.x = 0.6;				
			}
			if (e.keyCode == Keyboard.LEFT)
			{
				input.x = -0.6;
			}
			if (e.keyCode == Keyboard.DOWN)
			{
				input.y = -0.3;
			}
			if (e.keyCode == Keyboard.UP)
			{
				input.y = 0.6;
			}
		}
	}	
}
