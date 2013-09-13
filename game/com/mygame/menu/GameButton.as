package com.mygame.menu
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class GameButton extends MovieClip
	{
		public var startFrame:int;
		public var endFrame:int;
		public var playDirection:int;
		public var playAnim:int;
		public var direction:int;
		
		public function GameButton()
		{
			addEventListener(Event.ENTER_FRAME, enterFrame)
		}
		
		private function enterFrame(e:Event):void
		{
			if (playAnim)
			{
				if (direction)
				{
					if (this.endFrame >= currentFrame)
					{
						this.nextFrame()
					}
					else
					{
						this.playAnim = 0
					}
				}
				else
				{
					if (this.endFrame <= currentFrame)
					{
						this.prevFrame()
					}
					else
					{
						this.playAnim = 0;
					}
				}
			}
		
		}
		
		
		public function playMenu(endFrame:int, startFrame = null)
		{
			this.playAnim = 1;
			this.endFrame = endFrame;
			!startFrame ? this.startFrame = currentFrame : this.startFrame = startFrame;
			if (this.startFrame < this.endFrame)
			{
				this.direction = 1;
			}
			else if (this.startFrame > this.endFrame)
			{
				this.direction = 0;
			}
			else if (this.startFrame == this.endFrame)
			{
				trace('com.mygame.menu.GameButton startFrame = endFrame')
			}
		
		}
	
	}

}