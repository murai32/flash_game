package com.mygame
{
	import com.mygame.menu.Menu;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.text.TextField;
	
	public class Base extends MovieClip
	{
		/////остановилься на функиции destroy в Enemy
		public var gameMenu:Menu;
		var newHero:Hero;
		var gameLogic:GameLogic;
		var text:TextField = new TextField();
		//var showStartMenu:Boolean = true
		
		public function Base()
		{
			
			showMenu();
			trace("showMenu");
			
			
			addEventListener(Event.ENTER_FRAME, debug)
			
			trace(stage.stageWidth)
			
		}
		
		public function debug(e:Event):void
		{
			stage.stageHeight = 1000;
			//text.text = '';
			//text.appendText( 'MouseX: ' + stage.mouseX + ' MouseY: ' + stage.mouseY + ' \n ' );
			//text.appendText( 'gunX: ' + (newHero.x + newHero.bestGun.x) + ' gunY: ' + (newHero.y + newHero.bestGun.y) + '\n');
			//text.appendText('angle: ' + newHero.bestGun.angle)
		}
		
		public function  showMenu()
		{
			stage.addChild(gameMenu = new Menu(this));
		}
		
		public function startGame()
		{
			if(gameMenu)
			{
				stage.removeChild(gameMenu);
				gameMenu = null;
			}
			gameLogic = new GameLogic(this);
			stage.addChild(gameLogic);
		}
	}

}