package com.mygame 
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	public class GameLogic extends MovieClip 
	{	var base:Base;
		var hero:Hero;
		var backImg:Background;
		var enemy:Enemy;
		
		var enemies:Array = new Array();
		var strtNumEnemies = 6;
		var enInc:int = 2;
		public var gameIsOver:Boolean = false;
		
		var message;
		var scoreTxt:TextField;
		var helthTxt:TextField;
		var text:String = " ";
		var scoreTxtFormat:TextFormat = new TextFormat();
		var helthTxtFormat:TextFormat = new TextFormat();
		var score:int = 0;
		var gameOverText:GameOver;
		var gameWinText:GameWin;
		var skull:Skull;
		var hurt:Krest; 
		
		
		public function GameLogic(base:Base) 
		{
			this.base = base;
			addEventListener(Event.ADDED_TO_STAGE, addedToStage)
			addEventListener(Event.ENTER_FRAME, enterFrame)
			
		}
		
		private function addedToStage(e:Event):void 
		{	
			//оброботчик инициализирующий фон и прочие глупости
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			backImg = new Background();
			backImg.x = stage.stageWidth/2;
			backImg.y = stage.stageHeight/2;
			stage.addChild(backImg);
			
			hero = new Hero(this);
			stage.addChild(hero);
			
			createEnemies(strtNumEnemies);
			//enemy = new Enemy;
			//backImg.addChild(enemy);
			showScore();
			showHelth();
			
		}
		
		public function enterFrame(e:Event)
		{
			var bullets = hero.bestGun.bulletsArr;
			trace("врагов на поле");
				trace (enemies.length);
				
				//перебираем массив с объектами Враг
			for (var i:int = 0; i < enemies.length; i++)
			{
				for (var n:int = 0; n < bullets.length; n++ )
				{
					if (bullets[n].hitTestObject(enemies[i]))
					{
						trace("hit test object");
						bullets[n].destroy();
						bullets.splice(n, 1);
						enemies[i].state = 'dia';
					}
				}
				
				if (enemies[i].diaAnim.currentFrame == enemies[i].diaAnim.totalFrames)
				{
					enemies.splice(i, 1);
					++score;
				}
			}
			updateScore();
			// когда врагов перебил, подкидываю еще кучку
			
			if (enemies.length == 0 )
			{
				gameOver();
			}			
		}
		
		// цикл определяющий коль-во врагов
		public function createEnemies(num:int)
		{
			for (var i:int = 0; i < num; i++)
			{
				createEnemy()
			}
		}
		
		// функция запихивающая ссылку на объект врага и 
		// добовляющая врага на сцену
		
		public function createEnemy()
		{
			//var tmpEnemy = new Enemy();
			enemies.push(new Enemy(this));
			backImg.addChild(enemies[enemies.length - 1]);
		}
		public function randRange(minNum:Number, maxNum:Number):Number 
        {
            return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
        }
		public function removeEnemies(num:int){
			trace("ЗАПУСК МЕХАНИЗМА УДАЛЕНИЯ ВРАГОВ");
			trace ('пришедшее число' + num);
			trace ('ВРАГОВ К УДАЛЕНИЮ' + (num+1));
			deepTrace( enemies );
			for each (var enemy in enemies )
				{	
					if (enemy.alive==true){
					trace("враг в процессе удаления " );
					//enemies[i].removeEventListener(Event.ADDED_TO_STAGE, addedToStage)
//					enemies[i].removeEventListener(Event.ENTER_FRAME, enterFrame);
					enemy.destroy();
					//enemies.length--;
					};				}
					enemies.splice(0);
			}
		public function gameOver()
		{
			// тебя будем менять так где нужно
			hero.dead();
			hero = null;
			
			trace("врагов на поле перед удалением" + enemies.length);
			if (gameIsOver==true){
			gameOverText = new GameOver();
			gameOverText.x = stage.stageWidth / 2;
			gameOverText.y = stage.stageHeight / 2
			removeEnemies(enemies.length-1);
			}
			else
			{
			gameWinText = new GameWin();
			gameWinText.x = stage.stageWidth / 2;
			gameWinText.y = stage.stageHeight / 2;
				}
			trace("врагов на поле ПОСЛЕ УДАЛЕНИЯ " + enemies.length);
			
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage)
			removeEventListener(Event.ENTER_FRAME, enterFrame);
			//затераем ссылку на героя
			
			
			//base.stage.addChild(gameOverText);
			///ВЫЗОВ МЕНЮ
			if (gameIsOver==true){
				stage.addChild(gameOverText);
			}
			else{
				stage.addChild(gameWinText);
				};
			stage.removeChild(hurt);
			stage.removeChild(helthTxt);
			stage.addEventListener(MouseEvent.CLICK, callMenu);
			;
			
		}
		
		public function callMenu(evt:MouseEvent){
			stage.removeEventListener(MouseEvent.CLICK, callMenu);
			
			stage.removeChild(skull);
			stage.removeChild(scoreTxt);
			if (gameIsOver==true){
				stage.removeChild(gameOverText);;
			}
			else{
				stage.removeChild(gameWinText);
				};
			
			base.showMenu();
		}
		public function showHelth()
		{
			helthTxt = new TextField();
			helthTxt.setTextFormat(helthTxtFormat);
			helthTxtFormat.font = "Calibri";
			
			helthTxt.x = 125;
			helthTxt.y = 0;
			helthTxt.autoSize = flash.text.TextFieldAutoSize.CENTER;
			helthTxtFormat.size = 25;
			helthTxt.text = '100';
			helthTxt.setTextFormat(helthTxtFormat);
			stage.addChild(helthTxt);
			helthTxt.selectable = false;
			
			hurt = new Krest();
			hurt.y = 19;
			hurt.x = 140;
			stage.addChild(hurt)
		}
		public function updateHelth(hel:int)
		{
			
			
			var helth:String = String(Math.round(hel/50));
			trace (helth);
			helthTxt.text =  helth;
			helthTxt.setTextFormat(helthTxtFormat);
		};
		public function showScore()
		{
			scoreTxt = new TextField();
			scoreTxt.setTextFormat(scoreTxtFormat);
			scoreTxtFormat.font = "Calibri"
			scoreTxt.text = text;
			scoreTxt.x = 50;
			scoreTxt.y = 0;
			scoreTxt.autoSize = flash.text.TextFieldAutoSize.CENTER;
			scoreTxtFormat.size = 25;
			stage.addChild(scoreTxt);
			scoreTxt.selectable = false;
			
			skull = new Skull();
			skull.y = 17;
			skull.x = 50
			stage.addChild(skull)
		}
		
		public function updateScore()
		{
			scoreTxt.text = text + score.toString();
			scoreTxt.setTextFormat(scoreTxtFormat);
		}
		 public function deepTrace( obj : *, level : int = 0 ) : void{
        var tabs : String = "";
        for ( var i : int = 0 ; i < level ; i++, tabs += "\t" ){};
        
        for ( var prop : String in obj ){
            trace( tabs + "[" + prop + "] -> " + obj[ prop ] );
            deepTrace( obj[ prop ], level + 1 );
        }
    }
	}

}