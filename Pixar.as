//Aida Zuniga
//Toy Story Game - Culminating Grade 12, 2013

package {
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldType;
	import flash.events.MouseEvent; 
	import flash.events.Event; 
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	public class Pixar extends MovieClip{
		//Variables for movement:
		var acceleration:Number = 0.3;
		var accelerationY:Number = 0;
		var gravity:Number = 1.5;
		var vx:Number= 0;
		var vy:Number = 0;
		var friction:Number = 0.9;
		var bounce:Number = -0.2;
		var jumpForce:Number = -30;
		//Blooleans:
		var downFlag:Boolean = false;
		var rightFlag:Boolean = false;
		var leftFlag:Boolean = false;
		var isOnGround:Boolean = undefined;
		var falling:Boolean = undefined;		
		//Pictures of Buzz:
		var standingB:standBuzz = new standBuzz;
		var jumpingB:jumpBuzz = new jumpBuzz;
		var leftrunB:leftRunPic = new leftRunPic;
		var rightrunB:rightRunPic = new rightRunPic;
		//Buttons and main pictures:
		var instructPic:Instructions = new Instructions;
		var backB:homePic = new homePic;
		var iPage:instructPage = new instructPage;
		var levelPic:Levels = new Levels;
		var bOne:button1 = new button1;
		var bTwo:button2 = new button2;
		var bThree:button3 = new button3;
		//Backgrounds:
		var mainBack:Background = new Background;
		var myLost:gameOver = new gameOver;
		var myWin:gameWin = new gameWin;
		var roomBack:andyRoom = new andyRoom;
		var airBack:Airport = new Airport;
		var trashBack:trashScene = new trashScene;
		//Blocks and falling objects:
		var rocket:blockPic;
		var alienPic:Alien;
		var cubePic:Cube;
		var luggage:casePic;
		var hammerPic:Hammer;
		var woodyH:WHat;
		var flame:Fire;
		var fireBlock:trashBlock;
		var jessiePic:Jessie;
		//Block Arrays:
		var myBlocks:Array = new Array();
		var myLuggages:Array = new Array();
		var myGarbage:Array = new Array();
		//Objects Arrays:
		var myAliens:Array = new Array();
		var myCubes:Array = new Array();
		var myHats:Array = new Array();
		var myHammers:Array = new Array();
		var myJessie:Array = new Array(); 
		var myFires:Array = new Array();
		//Timers:
		var buzzTimer:Timer = new Timer(5);
		var wallTimer:Timer = new Timer(10);
		var fallTimer:Timer = new Timer(5);	//Make rockets fall
		var createTimer:Timer = new Timer(1000);	//Creates new blocks
		var addCatch:Timer = new Timer(5500);	//Creates new objects to capture
		var addAvoid:Timer = new Timer(11000);	//Creates objects to avoid
		//Textboxes and counters:
		var gamePoints:Number =0;
		var pointsT:TextField = new TextField();
		var finalScore:TextField = new TextField();
		var tFormat:TextFormat = new TextFormat();
		
		function Pixar(){
			
			mainBack.height = stage.stageHeight;
			mainBack.width = stage.stageWidth;
			addChild(mainBack);
			
			standingB.x = 700;
			standingB.width = 100;
			standingB.height = 150;
			standingB.y = -10;
			
			instructPic.x = 700;
			instructPic.y = 150;
			instructPic.height = 75;
			instructPic.width = 200;
			instructPic.buttonMode = true;
			instructPic.addEventListener (MouseEvent.CLICK, instPage);
			addChild(instructPic);

			levelPic.x = 680;
			levelPic.y = 440;
			levelPic.height = 130;
			levelPic.width = 230;
			addChild(levelPic)
			
			bOne.x = 650;
			bOne.y = 600;
			bOne.width = 55;
			bOne.height = 100;
			bOne.buttonMode = true;
			addChild(bOne);
			bOne.addEventListener(MouseEvent.CLICK, startGame1);	//Event Listener to start level 1
			
			bTwo.x = 750;
			bTwo.y = 600;
			bTwo.width = 55;
			bTwo.height = 100;
			bTwo.buttonMode = true;
			bTwo.addEventListener(MouseEvent.CLICK, startGame2);	//Event Listener to start level 2
			addChild(bTwo);
			
			bThree.x = 850;
			bThree.y = 600;
			bThree.width = 55;
			bThree.height = 100;
			bThree.buttonMode = true;
			bThree.addEventListener(MouseEvent.CLICK, startGame3);	//Event Listener to start level 3
			addChild(bThree);
			
			pointsT.x = 830;	//Textbox for points
			pointsT.y = 10;
			pointsT.width = 100;
			pointsT.height = 30;
			pointsT.text = String(gamePoints);	//Strings the gamePoints interger to the textbox
			tFormat.size = 30;
			pointsT.setTextFormat(tFormat)	//Sets the tFormat to the pointsT textbox
			
			finalScore.width = 100;
			finalScore.height = 30;
			finalScore.y = 60;
			finalScore.x = 750;
			finalScore.setTextFormat(tFormat) //Sets the tFormat to the pointsT textbox
			
			myLost.width = stage.stageWidth;	//Picture that appears when you lose
			myLost.height = stage.stageHeight;	//Picture to dissapear when you win
			
			myWin.width = stage.stageWidth;	//Picture to appear when you win
			myWin.height = stage.stageHeight;
			
			buzzTimer.addEventListener(TimerEvent.TIMER, buzzFall);	//The event listeners for all the timers
			wallTimer.addEventListener(TimerEvent.TIMER, wallFall);
			fallTimer.addEventListener(TimerEvent.TIMER, fallingTimer);
			
			createTimer.addEventListener(TimerEvent.TIMER, creatingTimer);
			addCatch.addEventListener(TimerEvent.TIMER, catchingObject);
			addAvoid.addEventListener(TimerEvent.TIMER, avoidingObject);
		}
		
		public function instPage(event:MouseEvent){	//Page for instructions
			iPage.width = 950;	//Instruction background
			iPage.height = 800;
			addChild(iPage);
			
			removeChild(mainBack);
			removeChild(instructPic);
			removeChild(levelPic);
			removeChild(bOne);
			removeChild(bTwo);
			removeChild(bThree);
			
			backB.x = 40;	//Picture for the home button
			backB.y = 30;
			backB.width = 75;
			backB.height = 75;
			backB.buttonMode = true;
			backB.addEventListener(MouseEvent.CLICK, returnHome);
			addChild(backB);
		}
		
		public function returnHome(event:MouseEvent){//Return hom from instructions
			standingB.x = 700;
			standingB.width = 100;
			standingB.height = 150;
			standingB.y = 0;
			
			addChild(mainBack);
			addChild(instructPic);
			addChild(levelPic);
			addChild(bOne);
			addChild(bTwo);
			addChild(bThree);
			removeChild(iPage);
		}
		
		public function startGame1(event:MouseEvent){	//Function to starts level 1 Game
			roomBack.y = -5600;
			roomBack.width = stage.stageWidth;
			addChild (roomBack);
			
			buzzTimer.start();
			wallTimer.start();
			
			createTimer.start();
			fallTimer.start();
			addCatch.start();
			addAvoid.start();
			
			pointsT.x = 830;
			pointsT.y = 10;
			pointsT.width = 200;
			pointsT.height = 60;
			pointsT.text = String(gamePoints);
			tFormat.size = 50;
			pointsT.defaultTextFormat = tFormat;			
			removeChild(mainBack);

			removeChild(instructPic);
			removeChild(levelPic);
			removeChild(bOne);
			removeChild(bTwo);
			removeChild(bThree);
			
			addChild(pointsT);
			
			standingB.x = 700;
			standingB.width = 100;
			standingB.height = 150;
			standingB.y = -10;
			addChild (standingB);
			
			jumpingB.x = 400;
			jumpingB.width = 120;
			jumpingB.height = 170;
			jumpingB.y = stage.stageHeight -jumpingB.height;
			addChild (jumpingB);
				
			leftrunB.width = 80;
			leftrunB.height = 130;
			leftrunB.y = stage.stageHeight -leftrunB.height;
			leftrunB.visible = false;
			addChild (leftrunB);
			
			rightrunB.width = 80;
			rightrunB.height = 130;
			rightrunB.y = stage.stageHeight -rightrunB.height;
			rightrunB.visible = false;
			addChild(rightrunB); 
			
			for (var a:int=0; a<2; a++){//The first two blocks that appear as soon as the level 1 game starts since the timer starts too late
				myBlocks[a] = new blockPic;
				myBlocks[a].x = 200 + a* 400;//Gives them exact y and x values
				myBlocks[a].y = 100 + a* 100;
				myBlocks[a].width = 250;
				myBlocks[a].height = 50;
				addChild(myBlocks[a]);
			}
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyD);//Event listener when a key is pressed down
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyU);//Event listener when no key if pressed down
			addEventListener(Event.ENTER_FRAME, looping);//Event listenert that is always looping
		}
		
		public function startGame2(event:MouseEvent){	//Function to starts level 2 Game
			airBack.y = -5800;
			airBack.width = stage.stageWidth;
			addChild (airBack);
			
			buzzTimer.start();
			wallTimer.start();
			
			createTimer.start();
			fallTimer.start();
			addAvoid.start();
			addCatch.start();
		
			removeChild(mainBack);

			removeChild(instructPic);
			removeChild(levelPic);
			removeChild(bOne);
			removeChild(bTwo);
			removeChild(bThree);
			
			addChild(pointsT);
						
			standingB.x = 700;
			standingB.width = 100;
			standingB.height = 150;
			standingB.y = 0//stage.stageHeight-standingB.height;
			addChild (standingB);
			
			jumpingB.x = 400;
			jumpingB.width = 120;
			jumpingB.height = 170;
			jumpingB.y = stage.stageHeight -jumpingB.height;
			addChild (jumpingB);
			
			leftrunB.width = 80;
			leftrunB.height = 130;
			leftrunB.y = stage.stageHeight -leftrunB.height;
			leftrunB.visible = false;
			addChild (leftrunB);
			
			rightrunB.width = 80;
			rightrunB.height = 130;
			rightrunB.y = stage.stageHeight -rightrunB.height;
			rightrunB.visible = false;
			addChild(rightrunB);

			pointsT.x = 830;
			pointsT.y = 10;
			pointsT.width = 200;
			pointsT.height = 60;
			pointsT.text = String(gamePoints);
			tFormat.size = 50;
			tFormat.color = 0xFFFFFF;	//Makes the colour of the fotn white
			pointsT.defaultTextFormat = tFormat;	//Sets the format to the pointsT
			
			for (var b:int=0; b<2; b++){//The first two blocks that appear as soon as the level 1 game starts since the timer starts too late
				myLuggages[b] = new casePic;
				myLuggages[b].x = 200 + b* 400;	//Gives them exact y and x values
				myLuggages[b].y = 100 + b* 100;
				myLuggages[b].width = 250;
				myLuggages[b].height = 50;
				addChild(myLuggages[b]);
			}
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyD);//Event listener when a key is pressed down
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyU);//Event listener when no key if pressed down
			addEventListener(Event.ENTER_FRAME, looping);//Event listenert that is always looping
		}
		
		public function startGame3(event:MouseEvent){	//Function to starts level 3 Game
			
			trashBack.y = -5600;
			trashBack.width = stage.stageWidth;
			addChild (trashBack);
			
			buzzTimer.start();
			wallTimer.start();
			
			createTimer.start();
			fallTimer.start();
			addCatch.start();
			addAvoid.start();
			
			removeChild(mainBack);

			removeChild(instructPic);
			removeChild(levelPic);
			removeChild(bOne);
			removeChild(bTwo);
			removeChild(bThree);
			
			addChild(pointsT);
			
			standingB.x = 700;
			standingB.width = 100;
			standingB.height = 150;
			standingB.y = 0//stage.stageHeight-standingB.height;
			addChild (standingB);
			
			jumpingB.x = 400;
			jumpingB.width = 120;
			jumpingB.height = 170;
			jumpingB.y = stage.stageHeight -jumpingB.height;
			addChild (jumpingB);
			
			leftrunB.width = 80;
			leftrunB.height = 130;
			leftrunB.y = stage.stageHeight -leftrunB.height;
			leftrunB.visible = false;
			addChild (leftrunB);
			
			rightrunB.width = 80;
			rightrunB.height = 130;
			rightrunB.y = stage.stageHeight -rightrunB.height;
			rightrunB.visible = false;
			addChild(rightrunB);
			
			pointsT.x = 830;
			pointsT.y = 10;
			pointsT.width = 200;
			pointsT.height = 60;
			pointsT.text = String(gamePoints);
			tFormat.size = 50;
			tFormat.color = 0xFFFFFF;	//Sets format font colour to white
			pointsT.defaultTextFormat = tFormat;
			
			for (var c:int=0; c<2; c++){//The first two blocks that appear as soon as the level 1 game starts since the timer starts too late
				myGarbage[c] = new trashBlock;
				myGarbage[c].x = 200 + c* 400; //Gives them exact y and x values
				myGarbage[c].y = 100 + c* 100;
				myGarbage[c].width = 250;
				myGarbage[c].height = 50;
				addChild(myGarbage[c]);
			}

			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyD);//Event listener when a key is pressed down
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyU);//Event listener when no key if pressed down
			addEventListener(Event.ENTER_FRAME, looping);//Event listenert that is always looping
		}
		
		public function KeyD(event:KeyboardEvent){
			//buzzTimer.start();	//Buzz timer (him falling) starts
			downFlag = true;	//Indicates that a keyboard button is pressed
			if (event.keyCode == Keyboard.UP){//When the key down is beign pressed
				if(isOnGround == true){
					buzzTimer.stop();	//Stops the timer that makes buzz y value increase by 1 (makes him fall)
					falling = false; //Indicates that Buzz is not falling
					accelerationY = jumpForce;	//The accelerationY because Buzz's jumpforce (the forcae at which he jumps)
					
					gravity = 0;	//Gravity becomes 0 so he can jump
					//leftFlag = false;	//Booleans for going left and right become false
					//rightFlag = false;
					isOnGround = false;	//Indicates that Buzz is no longer on the ground
				}
				vy += accelerationY;	//the vy is added the acceleration Y so he gradually increases in speed
			}
			if (event.keyCode == Keyboard.SPACE){	//When the space bar is pressed
				for (var d:int = 0; d<myAliens.length; d++){
					if(standingB.hitTestObject(myAliens[d])){	//If Buzz is in contact with an alien and the space bar is pressed, the alien dissapears and points are added
					   myAliens[d].visible = false;
					   gamePoints+= 25;
					}
				}
				for (var e:int = 0; e<myHats.length; e++){	//If Buzz is in contact with a hat and the space bar is pressed, the hat dissapears and points are added
					if(standingB.hitTestObject(myHats[e])){
					   myHats[e].visible = false;
					   gamePoints+= 35;
					}
				}
				for (var f:int = 0; f<myJessie.length; f++){	//If Buzz is in contact with Jessie and the space bar is pressed, Jessie dissapears and points are added
					if(standingB.hitTestObject(myJessie[f])){
					   myJessie[f].visible = false;
					   gamePoints+= 50;
					}
				}
				pointsT.text = String(gamePoints);	//Strings the game points into the textbox
			}
			if (event.keyCode == Keyboard.LEFT){//When the key left is beign pressed
				standingB.visible = false;	//Make jumping and rightrun pictures invisible
				rightrunB.visible = false;
				rightFlag = false;	//Turn off the right flag boolean
				leftFlag = true;	//Turn on the left flag boolean to move left
				if (jumpingB.visible == false){		//Only when the jumping picture is no visible, make the left picture visible
					leftrunB.visible = true;
				}
				else{
					leftrunB.visible = false;
				}
			}
			if (event.keyCode == Keyboard.RIGHT){//When the key right is beign pressed
				standingB.visible = false;	//Make jumping and lefttrun pictures invisible
				leftrunB.visible = false;
				leftFlag = false;	//Turn off the left flag boolean
				rightFlag = true;	//Turn on the right flag boolean to move right
				if (jumpingB.visible == false){	//Only when the jumping picture is no visible, make the right picture visible
					rightrunB.visible = true;
				}
				else{
					rightrunB.visible = false;
				}
			}
		}
		public function KeyU(event:KeyboardEvent){	//When no key is being pressed
			standingB.visible = true;	//Only make the standing picture of Buzz visible
			jumpingB.visible = false;
			rightrunB.visible = false;
			leftrunB.visible = false;
			downFlag = false;
		}

		public function wallFall(event:TimerEvent){	//Function to make the backgrounds gradually drop when the games start
			roomBack.y++;
			airBack.y++;
			trashBack.y++;
		}
		
		public function buzzFall(event:TimerEvent){	//Function to make Buzz fall along with the blocks so when he's no doing anything, he is still on top of them and not flying above in the air
			standingB.y++;
			jumpingB.y++;
			rightrunB.y++;
			leftrunB.y++;
		}
		public function creatingTimer(event:TimerEvent){	
			if (roomBack.stage !=null){	//When Andy's room picture is in the stage
				rocket = new blockPic;		//Timer to create new rockets and push them into "myBlocks" array
				rocket.width = 250;
				rocket.height = 50;
				rocket.visible = true;
				rocket.y = 0;
				rocket.x = Math.round(Math.random()*750)+10;
				myBlocks.push(rocket);
				addChildAt (rocket, 1);
				
			}
			if (airBack.stage !=null){	//When the airprot picture is in the stage
				luggage = new casePic;		//Timer to create new luggages and push them into "myLuggages" array
				luggage.width = 250;
				luggage.height = 50;
				luggage.visible = true;
				luggage.y = 0;
				luggage.x = Math.round(Math.random()*750)+10;
				myLuggages.push(luggage);
				addChildAt (luggage, 1);
			}
			if (trashBack.stage !=null){	//When the garbage scene picture is in the stage
				fireBlock = new trashBlock;		//Timer to create new blocks and push them into "myGarbage" array
				fireBlock.width = 250;
				fireBlock.height = 50;
				fireBlock.visible = true;
				fireBlock.y = 0;
				fireBlock.x = Math.round(Math.random()*750)+10;
				myGarbage.push(fireBlock);
				addChildAt (fireBlock, 1);
			}
		}
		
		public function fallingTimer(event:TimerEvent){	//Timer to make the rockets fall
			if (roomBack.stage !=null){	//When Andy's room picture is in the stage
				for(var g:int = 0; g<myBlocks.length; g++){
					myBlocks[g].y++;
					if (myBlocks[g].y>805){	//If rockets reach y value of 805, they will be removed from array and from the stage
						gamePoints +=10;
						removeChild (myBlocks[g]);
						myBlocks.splice(g,1);
					}
				}
				pointsT.text = String(gamePoints);
			}
			if (airBack.stage !=null){	//When the airprot picture is in the stage
				for(var h:int = 0; h<myLuggages.length; h++){
					myLuggages[h].y++;
					if (myLuggages[h].y>805){	//If luggages reach y value of 805, they will be removed from array and from the stage
						gamePoints +=15;
						removeChild (myLuggages[h]);
						myLuggages.splice(h,1);
					}
				}
				pointsT.text = String(gamePoints);
			}
			if (trashBack.stage !=null){	//When the garbage scene picture is in the stage
				for(var i:int = 0; i<myGarbage.length; i++){
					myGarbage[i].y++;
					if (myGarbage[i].y>805){	//If fire blocks reach y value of 805, they will be removed from array and from the stage
						gamePoints+=20;
						removeChild (myGarbage[i]);
						myGarbage.splice(i,1);
					}
				}
				pointsT.text = String(gamePoints);
			}
		}
		
		public function catchingObject(event:TimerEvent){	//Timer to create new objects and push them into their arrays while giving them a random x value
			if (roomBack.stage !=null){	//When Andy's room picture is in the stage
				alienPic = new Alien;
				alienPic.width = 50;
				alienPic.height = 50;
				alienPic.y = 0;
				alienPic.x = Math.round(Math.random()*750)+50;
				myAliens.push(alienPic);
				addChild (alienPic);
			}
			if (airBack.stage !=null){	//When the airprot picture is in the stage
				woodyH = new WHat;
				woodyH.width = 50;
				woodyH.height = 50;
				woodyH.y = 0;
				woodyH.x = Math.round(Math.random()*750)+50;
				myHats.push(woodyH);
				addChild(woodyH);
			}
			if (trashBack.stage !=null){	//When the garbage scene picture is in the stage
				jessiePic = new Jessie;
				jessiePic.width = 120;
				jessiePic.height = 85;
				jessiePic.y = 0;
				jessiePic.x = Math.round(Math.random()*700)+50;
				myJessie.push(jessiePic);
				addChild(jessiePic);
			}
		}
		
		public function avoidingObject(event:TimerEvent){	//Timer to create new objects and push them into their array while giving them random x value, and specific widths, heights and a y-value of 0
			if (roomBack.stage !=null){	//When Andy's room picture is in the stage
				cubePic = new Cube;
				cubePic.y = 0;
				cubePic.x = Math.round(Math.random()*700)+50;
				myCubes.push(cubePic);
				addChild (cubePic);
			}
			if (airBack.stage !=null){	//When the airprot picture is in the stage
				hammerPic = new Hammer;
				hammerPic.y = 0;
				hammerPic.x = Math.round(Math.random()*700)+50;
				myHammers.push(hammerPic);
				addChild (hammerPic);
			}
			if (trashBack.stage !=null){	//When the garbage scene picture is in the stage
				flame = new Fire;
				flame.y = -50;
				flame.x = Math.round(Math.random()*700)+50;
				myFires.push(flame);
				addChild (flame);
			}
		}
		
		public function looping(event:Event){	//The looping function that is always occuring in the program
			
			standingB.y += vy;	//Make the standing and jumping pictures always increase their y-values by vy
			jumpingB.y += vy;
			
			jumpingB.x = standingB.x;	//Make sure that every picture's y and x values are the same as the standing Buzz picture's
			jumpingB.y = standingB.y;
			leftrunB.x = standingB.x;
			leftrunB.y = standingB.y+20;
			rightrunB.x = standingB.x;
			rightrunB.y = standingB.y+20;
			
			
			/*if (standingB.y >= stage.stageHeight - standingB.height){//When buzz standing is on the ground
				isOnGround = true;	//Make boolean for ground be true
				vy = 0;
				gravity = 0;
				standingB.y = stage.stageHeight - standingB.height;
				jumpingB.y = stage.stageHeight - jumpingB.height;
				jumpingB.visible = false;
				
				if ((rightrunB.visible == false)&&(leftrunB.visible == false)){
					standingB.visible = true;
				}
			}*/
			
			if (standingB.y >= stage.stageHeight){	//When buzz falls through the ground
				buzzTimer.stop();	//stop all the timers
				wallTimer.stop();
				
				fallTimer.stop();
				createTimer.stop();
				addCatch.stop();
				addAvoid.stop();
				
				removeChild(standingB);	//Remove Buzz pictures form the stage
				removeChild(jumpingB);
				removeChild(rightrunB);
				removeChild(leftrunB);
				
				backB.x = 40;
				backB.y = 30;
				backB.width = 75;
				backB.height = 75;
				backB.buttonMode = true;
				backB.addEventListener(MouseEvent.CLICK, returnHome);
				addChild(backB);	//add the home button
				addChildAt(myLost,1);	//add the game over picture behind the home button picture
					
				removeChild(pointsT);	//remove the points textbox
				
				if (roomBack.stage !=null){	//When the room picture is on the stage, remove the rockets, aliens and cubes
					removeChild(roomBack);

					for (var a:int = 0; a<myBlocks.length; a++){
						myBlocks[a].visible = false;
						removeChild (myBlocks[a]);
						myBlocks.splice(a,1);
						//trace(myBlocks.length);
						//myBlocks[a].y = 1500;
					}
					
					for (var f:int = 0; f<myAliens.length; f++){
						myAliens[f].visible = false;
						removeChild (myAliens[f]);
						myAliens.splice(f,1);
						
						myCubes[f].visible = false;
						removeChild (myCubes[f]);
						myCubes.splice(f,1);
					}
					
				}
				if (airBack.stage !=null){	//When the airport picture is on the stage, remove the luggages, hats and hammers
					removeChild(airBack);
					
					for (var w:int = 0; w<myLuggages.length; w++){
						//myLuggages[w].visible = false;
						removeChild (myLuggages[w]);
						myLuggages.splice(w,1);
					}
					
					for (var j:int = 0; j<myHats.length; j++){
						myHats[j].visible = false;
						removeChild (myHats[j]);
						myHats.splice(j,1);
						
						myHammers[j].visible = false;
						removeChild (myHammers[j]);
						myHammers.splice(j,1);
					}
					
				}
				if (trashBack.stage !=null){	//When the grabage scene picture is on the stage, remove the blocks, Jessies and firesballs
					removeChild(trashBack);
					
					for (var az:int = 0; az<myGarbage.length; az++){
						//myGarbage[az].visible = false;
						removeChild (myGarbage[az]);
						myGarbage.splice(az,1);
					}
					
					for (var ab:int = 0; ab<myJessie.length; ab++){
						myJessie[ab].visible = false;
						removeChild (myJessie[ab]);
						myJessie.splice(ab,1);
						
						myFires[ab].visible = false;
						removeChild (myFires[ab]);
						myFires.splice(ab,1);
					}
				}
			}
			
			if (isOnGround == false){//When isOnGround is false, turn off acceleration and turn on gravity
				buzzTimer.start();	//Make Buzz's timer to fall start
				accelerationY = 0; 	//There is no acceleration to go up
				gravity = 1.2;	//Gravity becomes 1.2
				vy += gravity; //vy is constantly being added the gravity
				jumpingB.visible = true;	//Makes all pictures invisible except the jumping picture
				standingB.visible = false;
				rightrunB.visible = false;
				leftrunB.visible = false;
			}
			
			if ((downFlag == true)){//When a button is pressed
				if (rightFlag == true){//Moving right
					vx += acceleration;	//vx is constantly being added the aceleration
					standingB.x += vx;	//buzz is speeding up to the right
				}
				else if (leftFlag == true){//Moving left
					vx += acceleration;	//vx is constantly being added the aceleration
					standingB.x -= vx;	//buzz is speeding up to the left
				}
			}
					
			if (downFlag == false){//When a button is not pressed
				vx*= friction;	//turn friction on
				if (Math.abs(vx)<0.5){	//if the friction is less than 0.5, then make vx equal zero and stop Buzz from moving since the movement is so little it cannot be seen
					vx = 0;
				}
				if (rightFlag == false){
					standingB.x -= vx;
				}
				if (leftFlag == false){
					standingB.x += vx;
				}
			}
			
			/*if (roomBack.y>-100){//When the background picture is almost done, finish game
				gamePoints+100;
				removeChild(roomBack);
				buzzTimer.stop();
				wallTimer.stop();
				createTimer.stop();
				addCatch.stop();
				addAvoid.stop();
				for (var ae:int = 0; ae<myBlocks.length; ae++){
					myBlocks[ae].visible = false;
					removeChild (myBlocks[ae]);
					myBlocks.splice(ae,1);
				}
				removeChild(standingB);
				removeChild(shootingLB);
				removeChild(shootingRB);
				removeChild(jumpingB);
				removeChild(rightrunB);
				removeChild(leftrunB);
				
				backB.x = 40;
				backB.y = 30;
				backB.width = 75;
				backB.height = 75;
				backB.buttonMode = true;
				backB.addEventListener(MouseEvent.CLICK, returnHome);
				addChild(backB);
				addChild(myWin);
				
				finalScore = pointsT;
				finalScore.border = true;
				addChild(finalScore);
			}
				
			if (airBack.y>-100){//When the background picture is almost done, finish game
				gamePoints+100;
				removeChild(airBack);
				buzzTimer.stop();
				wallTimer.stop();
				createTimer.stop();
				addCatch.stop();
				addAvoid.stop();
				for (var ac:int = 0; ac<myLuggages.length; ac++){
					myLuggages[ac].visible = false;
					removeChild (myLuggages[ac]);
					myLuggages.splice(ac,1);
				}
				removeChild(standingB);
				removeChild(shootingLB);
				removeChild(shootingRB);
				removeChild(jumpingB);
				removeChild(rightrunB);
				removeChild(leftrunB);
				
				backB.x = 40;
				backB.y = 30;
				backB.width = 75;
				backB.height = 75;
				backB.buttonMode = true;
				backB.addEventListener(MouseEvent.CLICK, returnHome);
				addChild(backB);
				addChild(myWin);
				
				finalScore = pointsT;
				addChild(finalScore);
			}
			
			if (trashBack.y>-100){//When the background picture is almost done, finish game
				gamePoints+100;
				removeChild(trashBack);
				buzzTimer.stop();
				wallTimer.stop();
				createTimer.stop();
				addCatch.stop();
				addAvoid.stop();
				for (var ad:int = 0; ad<myLuggages.length; ad++){
					myGrabage[ad].visible = false;
					removeChild (myGarabage[ad]);
					myGarbage.splice(ad,1);
				}
				removeChild(standingB);
				removeChild(shootingLB);
				removeChild(shootingRB);
				removeChild(jumpingB);
				removeChild(rightrunB);
				removeChild(leftrunB);
				
				backB.x = 40;
				backB.y = 30;
				backB.width = 75;
				backB.height = 75;
				backB.buttonMode = true;
				backB.addEventListener(MouseEvent.CLICK, returnHome);
				addChild(backB);
				addChild(myWin);
				
				finalScore = pointsT;
				addChild(finalScore);
			}*/
			
			if ((standingB.x + standingB.width >stage.stageWidth)||(rightrunB.x + rightrunB.width >stage.stageWidth)){//Bounce from right wall
				vx *= bounce;
				standingB.x = stage.stageWidth - standingB.width;
			}
			else if ((standingB.x <0)||(leftrunB.x<0)){//Bounce from left wall
				vx *= bounce;
				standingB.x = 0;
			}
			if (jumpingB.y<0){
				vy = 0;
				jumpingB.y = 0;
			}
			for(var k:int = 0; k<myAliens.length; k++){
				myAliens[k].y+=5;
				if (myAliens[k].y>805){	//If rockets reach y value of 805, they will be removed from array and from the stage
					removeChild (myAliens[k]);
					myAliens.splice(k,1);
				}
			}
			for(var l:int = 0; l<myHats.length; l++){
				myHats[l].y+=5;
				if (myHats[l].y>805){	//If rockets reach y value of 805, they will be removed from array and from the stage
					removeChild (myHats[l]);
					myHats.splice(l,1);
				}
			}
			for(var m:int = 0; m<myJessie.length; m++){
				myJessie[m].y+=2;
				if (myJessie[m].y>805){	//If rockets reach y value of 805, they will be removed from array and from the stage
					removeChild (myJessie[m]);
					myJessie.splice(m,1);
				}
			}
			
			if (vy>0){//When y is positive, then falling is true
				falling = true;
			}
			else {//Otherwise falling is false
				falling = false;
			}
			if (falling == true){	//When he is falling
				if (roomBack.stage !=null){	//Code for blocks for level 1
					buzzTimer.start();
					for(var n:int = 0; n<myBlocks.length; n++){
						buzzTimer.start();
						if ((jumpingB.y >= myBlocks[n].y - jumpingB.height)&&(jumpingB.y + jumpingB.height <= myBlocks[n].y+myBlocks[n].height)&&(standingB.x >= myBlocks[n].x - myBlocks[n].width +200)&&(standingB.x <= myBlocks[n].x + myBlocks[n].width-40)){
							vy = 0;
							isOnGround = true;
							if ((rightrunB.visible == false)&&(leftrunB.visible == false)){
								standingB.visible = true;
							}
							if (standingB.visible == true){
								jumpingB.visible = false;
							}
							jumpingB.y = myBlocks[n].y - jumpingB.height;
							standingB.y = myBlocks[n].y - standingB.height;
							standingB.y = myBlocks[n].y - standingB.height;
							rightrunB.y = myBlocks[n].y - rightrunB.height;
							leftrunB.y = myBlocks[n].y - leftrunB.height;
						}
					}
				}
				if (airBack.stage !=null){	//Code for blocks for level 2
					buzzTimer.start();
					for(var o:int = 0; o<myLuggages.length; o++){
						if ((jumpingB.y >= myLuggages[o].y - jumpingB.height)&&(jumpingB.y + jumpingB.height <= myLuggages[o].y+myLuggages[o].height)&&(standingB.x >= myLuggages[o].x - myLuggages[o].width +185)&&(standingB.x <= myLuggages[o].x + myLuggages[o].width-40)){
							buzzTimer.start();
							vy = 0;
							isOnGround = true;
							if ((rightrunB.visible == false)&&(leftrunB.visible == false)){
								standingB.visible = true;
							}
							if (standingB.visible == true){
								jumpingB.visible = false;
							}
							jumpingB.y = myLuggages[o].y - jumpingB.height;
							standingB.y = myLuggages[o].y - standingB.height;
							standingB.y = myLuggages[o].y - standingB.height;
							rightrunB.y = myLuggages[o].y - rightrunB.height;
							leftrunB.y = myLuggages[o].y - leftrunB.height;
						}
					}
				}
				if (trashBack.stage !=null){	//Code for blocks for level 2
					buzzTimer.start();
					for(var p:int = 0; p<myGarbage.length; p++){
						if ((jumpingB.y >= myGarbage[p].y - jumpingB.height)&&(jumpingB.y + jumpingB.height <= myGarbage[p].y+myGarbage[p].height)&&(standingB.x >= myGarbage[p].x - myGarbage[p].width +185)&&(standingB.x <= myGarbage[p].x + myGarbage[p].width-40)){
							buzzTimer.start();
							vy = 0;
							isOnGround = true;
							if ((rightrunB.visible == false)&&(leftrunB.visible == false)){
								standingB.visible = true;
							}
							if (standingB.visible == true){
								jumpingB.visible = false;
							}
							jumpingB.y = myGarbage[p].y - jumpingB.height;
							standingB.y = myGarbage[p].y - standingB.height;
							standingB.y = myGarbage[p].y - standingB.height;
							rightrunB.y = myGarbage[p].y - rightrunB.height;
							leftrunB.y = myGarbage[p].y - leftrunB.height;
						}
					}
				}
			}
			if (roomBack.stage !=null){	//Code for blocks for level 1
				for(var q:int = 0; q<myBlocks.length; q++){
					if (standingB.y == myBlocks[q].y - standingB.height){	//When buzz is on top of rocket
						if (standingB.x<=myBlocks[q].x-standingB.width + 20){	//if buzz is on left of rocket, make him fall
							isOnGround = false;
						}
						else if (standingB.x >=myBlocks[q].x + myBlocks[q].width - 40){   //if buzz is on right of rocket, make him fall
							isOnGround = false;
						}
					}
				}
			}
			if (airBack.stage !=null){
				for(var r:int = 0; r<myLuggages.length; r++){
					if (standingB.y == myLuggages[r].y - standingB.height){	//When buzz is on top of rocket
						if (standingB.x<=myLuggages[r].x-standingB.width + 20){	//if buzz is on left of rocket, make him fall
							isOnGround = false;
						}
						else if (standingB.x >=myLuggages[r].x + myLuggages[r].width - 40){   //if buzz is on right of rocket, make him fall
							isOnGround = false;
						}
					}
				}
			}
			if (trashBack.stage !=null){
				for(var s:int = 0; s<myGarbage.length; s++){
					if (standingB.y == myGarbage[s].y - standingB.height){	//When buzz is on top of rocket
						if (standingB.x<=myGarbage[s].x-standingB.width + 20){	//if buzz is on left of rocket, make him fall
							isOnGround = false;
						}
						else if (standingB.x >=myGarbage[s].x + myGarbage[s].width - 40){   //if buzz is on right of rocket, make him fall
							isOnGround = false;
						}
					}
				}
			}
			
			if(roomBack.stage !=null){
				for(var t:int = 0; t<7; t++){
					myCubes[t].y+=8;
					myCubes[t].rotation++
					if(t==6){
						addAvoid.stop();
					}
					if (myCubes[t].y>805){	//If rockets reach y value of 805, they will be removed from array and from the stage
						myCubes[t].y = -500;
						myCubes[t].x = Math.round(Math.random()*750)+50;
					}
					if(standingB.hitTestObject(myCubes[t])){
						myCubes[t].y = 1300;
						gamePoints-=10;
					}
				}
			}
			if (airBack.stage !=null){
				for(var u:int = 0; u<7; u++){
					myHammers[u].y+=8;
					myHammers[u].rotation++
					if(u==6){
						addAvoid.stop();
					}
					if (myHammers[u].y>805){	//If rockets reach y value of 805, they will be removed from array and from the stage
						myHammers[u].y = -500;
						myHammers[u].x = Math.round(Math.random()*750)+50;
					}
					if(standingB.hitTestObject(myHammers[u])){
						myHammers[u].y = 1300;
						gamePoints-=15;
					}
				}
			}
			if (trashBack !=null){
				for(var v:int = 0; v<15; v++){
					myFires[v].y+=17;
					if(v==14){
						addAvoid.stop();
					}
					if (myFires[v].y>805){	//If rockets reach y value of 805, they will be removed from array and from the stage
						myFires[v].y = -500;
						myFires[v].x = Math.round(Math.random()*750)+50;
					}
					if(standingB.hitTestObject(myFires[v])){
						myFires[v].y = 2300;
						gamePoints -= 20;
					}
				}
			}
		}	//End of looping function
	}
}
