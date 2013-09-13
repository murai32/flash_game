package com.mygame 
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.Point;
	
	public class Background extends MovieClip 
	{
		var leftBorder:int;
		var rightBorder:int;
		
		public function Background() 
		{	
			//leftBorder = -width / 2;
//			rightBorder = width / 2;
			//задаем границы сцены (сдвинул сцену на 630a единиц)
			leftBorder = -255;
			rightBorder = 1555;	
		}
		
		public function getLeftBorder():int
		{
			var point:Point = new Point(leftBorder, 0)
			var globLBorder:Point = localToGlobal(point);
			
			return globLBorder.x;
		}
		
		public function getRightBorder():int
		{
			var point:Point = new Point(rightBorder, 0)
			var globRBorder:Point = localToGlobal(point);
			
			return globRBorder.x;
		}
		
		
	}

}