package com.mygame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class Gun extends MovieClip
	{
		private const START_POS_X:int = -10;
		private const START_POS_Y:int = 10;
		private const RANGE:int = 500;
		
		public var rateOfFire:int = 5;
		public var frame:int;
		public var angle:Number;
		public var direction:int;
		public var bulletsArr:Array = new Array();
		public var gameLogic;
		
		public function Gun(gameLogic)
		{
			addEventListener(Event.ENTER_FRAME, enterFrame);
			this.x = START_POS_X;
			this.y = START_POS_Y;
			this.gameLogic = gameLogic;
		}
		
		private function enterFrame(e:Event):void
		{
			if (!gameLogic.gameIsOver)
			{
				followMouse();
			}
			
			removeBullet();
		}
		
		public function followMouse()
		{
			angle = Math.atan2(parent.y + this.y - stage.mouseY, parent.x + this.x - stage.mouseX);
			angle = angle * 180 / Math.PI;
			this.rotation = angle - 180;
			
			if (this.rotation >= 90 || this.rotation <= -90)
			{
				parent.scaleX = gameLogic.hero.scale * -1;
				this.scaleY = -1
				this.scaleX = -1
				this.rotation *= -1;
			}
			else
			{
				parent.scaleX = gameLogic.hero.scale;
				this.scaleX = 1
				this.scaleY = 1
			}
		
		}
		public function shot()
		{
			var bullet;
			var point:Point = new Point(140, 60);
			point = localToGlobal(point);
			bulletsArr.push(new Bullet());
			bullet = bulletsArr[bulletsArr.length - 1];
			bullet.x = point.x;
			bullet.y = point.y;
			
			this.rotation >= 90 || this.rotation <= -90 ? bullet.rotation = this.rotation * -1 : bullet.rotation = this.rotation;
			bullet.name = 'bullet';
			stage.addChild(bullet);
			
		}
		
		public function startShooting()
		{
			if (frame >= rateOfFire)
			{
				shot();
				frame = 0;
			}
			
			++frame;
		}
		
		public function removeBullet()
		{
			
			for (var index in bulletsArr)
			{
				
				if (bulletsArr[index])
				{
					if (bulletsArr[index].x < this.parent.x - RANGE || bulletsArr[index].x > this.parent.x + RANGE || bulletsArr[index].y < this.parent.y - RANGE || bulletsArr[index].y > this.parent.y + RANGE)
					{
						//stage.removeChild(bulletsArr[index]);
						bulletsArr[index].destroy();
						bulletsArr[index] = null
						bulletsArr.splice(index, 1);
					}
				}
				
			}
			
		}
	}
}