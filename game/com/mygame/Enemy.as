package com.mygame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;

	public class Enemy extends MovieClip
	{

		var scale:Number = 1.5;
		var startX:int = 100;
		//var startY:int = 100;
		var direction:int = 1;
		var speed:int = 5;
		var action:String = 'walk';
		var state:String = 'free';
		var distanceToHero:int;
		var hero;

		//Animations;
		var animArr:Array = new Array();//all childs
		var walkAnim;
		var slashAnim;
		var standAnim;
		var diaAnim;

		//to choose action
		var mediumDistance:int = 300;
		var closeDistance:int = 100;

		//used for some animations
		var timer;
		
		//шаг расстановки врагов
		static var cooof: int = 0;

		//Test
		var addTestObj:Boolean = false;
		public var alive:Boolean = true;

		var gameLogic;

		public function Enemy(GameLogic)
		{
			init();
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.ENTER_FRAME, enterFrame);

			this.gameLogic = GameLogic;
		}

		private function enterFrame(e:Event):void
		{
			trace("actMEEEE");

			act();
		}

		

		public function act():void
		{
			setDirection();
			var rnd:int = gameLogic.randRange(0,100);
			if (state == 'free')
			{
				if (calcDistToHero() > closeDistance)
				{
					if (rnd < 99)
					{
						walk();
					}
					else
					{
						stand();
					}


				}
				if (calcDistToHero() <= closeDistance)
				{
					if (rnd < 50)
					{
						slash();
					}
					else
					{
						stand();
					}
				}
			}

			switch (state)
			{
				case 'slash' :
					slash();
					break;
				case 'stand' :
					stand();
					break;
				case 'dia' :
					dia();
					break;
			}
		}

// добавленные
		private function addedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			hero = stage.getChildByName('hero');
			this.y = heroCoord().y + 18  ;
			// диапазон на котором появляются враги
			//this.x = gameLogic.randRange(0,2) ? x = 280:x = 1525;
			this.x = 200 + (cooof +=240);
			this.height = 110;
			this.scaleX = this.scaleY;
			trace(this.x);
		}

		public function init():void
		{
			for (var i:int; i < numChildren; i++)
			{
				animArr[i] = getChildAt(i);
				animArr[i].visible = false;
			}
			walkAnim = getChildByName('walkInst');
			slashAnim = getChildByName('slashInst');
			standAnim = getChildByName('standInst');
			diaAnim = getChildByName('diaInst');
			slashAnim.stop();
			diaAnim.stop();
			walkAnim.visible = true;
		}

		public function hideAllAnim():void
		{
			for each (var anim in animArr)
			{
				anim.visible = false;
			}
		}

		public function calcDistToHero():int
		{
			var distX = Math.abs(this.x - heroCoord().x);
			var distY = Math.abs(this.y - heroCoord().y);
			var dist = Math.sqrt(distX * distX + distY * distY);
			return dist;
		}

		public function heroCoord():Point
		{
			var globalHcoord:Point = hero.localToGlobal(new Point(0,0));
			var localHcoord:Point = parent.globalToLocal(globalHcoord);
			return localHcoord;
		}

		public function setDirection():void
		{
			if (heroCoord().x >= this.x && scaleX < 0)
			{
				scaleX *=  -1;
				direction *=  -1;
			}
			else if (heroCoord().x <= this.x && scaleX > 0)
			{
				scaleX *=  -1;
				direction *=  -1;
			}
		}

		private function walk():void
		{
			hideAllAnim();
			walkAnim.visible = true;
			x +=  speed * direction;
		}

		private function stand():void
		{


			if (! timer)
			{
				//trace('start timer')
				timer = gameLogic.randRange(10,20);
				hideAllAnim();
				standAnim.visible = true;
				state = 'stand'
				;
				//trace('timer = ' + timer)
			}
			if (timer >= 1)
			{
				//trace('timer = ' + timer)
				timer -=  1;
			}
			if (timer < 1)
			{
				timer = 0;
				state = 'free';
			}


		}

		private function slash():void
		{
			if (slashAnim.currentFrame == 1)
			{
				hideAllAnim();
				slashAnim.visible = true;
				slashAnim.play();
				state = 'slash';
			}
			else if (slashAnim.currentFrame == slashAnim.totalFrames)
			{
				slashAnim.gotoAndStop(1);
				state = 'free';
			};
/// тут можно описать алгоритм уменьшения здоровья героя
				if (gameLogic.hero.helth>0){
				gameLogic.hero.helth -= 10;};
				gameLogic.updateHelth(gameLogic.hero.helth);
				//trace ("здоровье игрока" + gameLogic.hero.helth);
				if (gameLogic.hero.helth == 0){
						gameLogic.gameIsOver=true;
						gameLogic.gameOver();
					}
		}

		private function dia():void
		{
			if (diaAnim.currentFrame == 1)
			{
				hideAllAnim();
				diaAnim.visible = true;
				diaAnim.play();
				state = 'dia';
			}
			else if (diaAnim.currentFrame == diaAnim.totalFrames)
			{
				
				destroy();
			}
		}
		public function destroy()
		{
			alive=false;
			removeEventListener(Event.ENTER_FRAME, enterFrame);
			parent.removeChild(this);
			trace("ВРАГ УДАЛЕН");
		}
	}
}