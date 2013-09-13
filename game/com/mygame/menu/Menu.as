package com.mygame.menu 
{
	import com.mygame.Base;
	import com.mygame.Hero;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.system.fscommand;
	
	
	public class Menu extends MovieClip 
	{
		public var menuItems:Array = new Array();
		public var numMenus:int = 2; //количество пунктов меню
		public var menuIndex;
		
		var base:Base;
		
		var menuBtn1:MovieClip;
		var menuBtn2:MovieClip;
		
		public function Menu(base:Base) 
		{
			this.base = base;
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.ENTER_FRAME, enterFrame);
			initMenuItems();
		}
		
		public function initMenuItems():void 
		{
			menuBtn1= new MenuButton1();
			menuBtn2= new MenuButton2();
			menuItems[0] = menuBtn2;
			menuItems[1] = menuBtn1;
			
			for (var i:int; i < numMenus; i++)
			{
				this.addChild(menuItems[i]);
				menuItems[i].y = -50 + 80 * i
				menuItems[i].name = i;
				trace('меня звать' + menuItems[i].name);
				menuItems[i].gotoAndStop(1);
				menuItems[i].addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
				menuItems[i].addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				this.addChild(menuItems[i]);
			}
		}
		
private function mouseDown(e:MouseEvent):void 
		{
			if (e.currentTarget.name == 0)
			{
//CТАРТ ИГРЫ	
				startGame();
			}
			if (e.currentTarget.name == 1)
			{
//ВЫХОД	
trace('выход');
				fscommand("quit");
			}
		}
		
		
		public function enterFrame(e:Event):void 
		{
		
		
		}
		
		public function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			x = stage.stageWidth / 2;
			y = stage.stageHeight / 2;
		}
		
		public function mouseOver(e:MouseEvent):void 
		{
			e.target.play();
			e.target.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
		}
		public function mouseOut(e:MouseEvent):void 
		{
			e.target.stop();
			e.target.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
		}
		
		public function startGame()
		{
			base.startGame();
		}
		
		public function destroy()
		{
			for (var i:int; i < numMenus; i++)
			{
			menuItems[i].removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			menuItems[i].removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			}
			menuItems = null;
		}
	}
}