package com.mygame
{
	import com.senocular.KeyObject;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	
	public class Hero extends MovieClip
	{
		private const START_POS_X:int = 275;
		private const START_POS_Y:int = 340;
		private const SPEED:int = 4;
		private const TRACE_KEY_CODE:Boolean = false;
		private const HERO_WIDTH = 50;
		public var shoot:int;
		
		var bestGun:Gun;
		var keyObj:KeyObject
		
		var gameLogic:GameLogic;
		var background:Background;
		//test
		var addTestObj:Boolean = false;
		var testObjSq:TestObjSq = new TestObjSq();
		
		var scale:Number = 0.8;
		public var helth:int = 5000;
		
		public function Hero(gameLogic:GameLogic)
		{
			this.gameLogic = gameLogic;
			background = this.gameLogic.backImg;
			
			x = START_POS_X;
			y = START_POS_Y;
			
			bestGun = new Gun(gameLogic);
			bestGun.x = -45;
			bestGun.y = -42;
			addChild(bestGun);
			addEventListener(Event.ADDED_TO_STAGE, heroRespawn);
			addEventListener(Event.ENTER_FRAME, enterFrame)
			this.name = 'hero';
			
			gotoAndStop(31);
			scaleX = scale;
			scaleY = scale;
		
		}
		
		private function heroRespawn(e:Event):void
		{
			keyObj = new KeyObject(stage);
			removeEventListener(Event.ADDED_TO_STAGE, heroRespawn);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
		
		private function keyDown(e:KeyboardEvent):void
		{
			if (TRACE_KEY_CODE)
			{
				trace(e.keyCode);
			}
		}
		
		private function enterFrame(e:Event):void
		{
			
			if (!gameLogic.gameIsOver)
			{
				if (keyObj.isDown(68))
				{
					moveRight()
				}
				else if (keyObj.isDown(65))
				{
					moveLeft()
				}
				else
				{
					standStill();
				}
				
				if (shoot)
				{
					fire();
				}
				
				if (addTestObj)
				{
					test();
				}
			}
			
			if (gameLogic.gameIsOver)
			{
				dead();
			}
		
		}
		
		private function mouseDown(e:MouseEvent):void
		{
			shoot = 1;
		}
		
		private function mouseUp(e:MouseEvent):void
		{
			shoot = 0;
			bestGun.frame = 10;
		}
		
		public function moveRight()
		{
			var rightBorder = background.getRightBorder() - HERO_WIDTH;
			var leftBorder = background.getLeftBorder() + HERO_WIDTH;
			
			
			if (x < rightBorder)
			{
				if (x < leftBorder + 225 || x > rightBorder - 225)
				{
					x += SPEED;
				}
				else
				{
					background.x -= SPEED;
				}
			}
			if (scaleX > 0)
			{
				playAnim(1, 30);
			}
			else
			{
				playAnim(30, 1);
			}
		
		}
		
		public function moveLeft()
		{
			var leftBorder = background.getLeftBorder() + HERO_WIDTH;
			var rightBorder = background.getRightBorder() - HERO_WIDTH;
			if (x > leftBorder)
			{
				
				if (x < leftBorder + 225 || x > rightBorder - 225)
				{
					x -= SPEED;
				}
				else
				{
					background.x += SPEED;
				}
			}
			
			if (scaleX < 0)
			{
				playAnim(1, 30);
			}
			else
			{
				playAnim(30, 1);
			}
		
		}
		
		public function fire()
		{
			bestGun.startShooting();
		}
		
		public function test():void
		{
			trace(gameLogic.backImg.getBounds(gameLogic));
			testObjSq.x = gameLogic.backImg.getBounds(gameLogic).x
			testObjSq.y = gameLogic.backImg.getBounds(gameLogic).y
			testObjSq.width = gameLogic.backImg.getBounds(gameLogic).width
			testObjSq.height = gameLogic.backImg.getBounds(gameLogic).height
		}
		
		public function playAnim(startFrame:int, endFrame:int)
		{
			
			if (startFrame < endFrame)
			{
				if (this.currentFrame < startFrame || this.currentFrame > endFrame)
				{
					gotoAndStop(startFrame);
				}
				
				if (this.currentFrame != endFrame)
				{
					nextFrame();
				}
				else if (this.currentFrame >= endFrame)
				{
					gotoAndStop(startFrame);
				}
			}
			
			if (startFrame > endFrame)
			{
				if (this.currentFrame > startFrame || this.currentFrame < endFrame)
				{
					gotoAndStop(startFrame);
				}
				
				if (this.currentFrame != endFrame)
				{
					prevFrame();
				}
				else if (this.currentFrame <= endFrame)
				{
					gotoAndStop(startFrame);
				}
			}
		}
		
		public function standStill()
		{
			playAnim(31, 60);
		}
		
		public function dead()
		{
			//removeEventListener(Event.ENTER_FRAME, enterFrame)
			if (currentFrame != 76)
			{
				playAnim(61, 76);
			}
			removeEventListener(Event.ENTER_FRAME, enterFrame);
			removeChild(bestGun);
			stage.removeChild(this);
			
		
		}
	
	}

}