package com.mygame
{
	import com.mygame.menu.GameButton;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Bullet extends MovieClip
	{
		public const SPEED:int = 12;
		public var directionX:Number;
		public var directionY:Number;
		
		public function Bullet()
		{
			addEventListener(Event.ENTER_FRAME, enterFrame)
			
			//this.directionX = directionX;
			//this.directionY = directionY;
		
		}
		
		private function enterFrame(e:Event):void
		{
			
			var angleRadians = this.rotation * Math.PI / 180
			this.x += SPEED * Math.cos(angleRadians);
			this.y += SPEED * Math.sin(angleRadians);
			//this.x += SPEED * this.directionX;
			//this.y += SPEED * this.directionY;
			//this.x += SPEED;
		
		}
		
		public function destroy()
		{
			stage.removeChild(this);
			this.removeEventListener(Event.ENTER_FRAME, enterFrame);
		}
	
	}

}