import flash.display.BitmapData;
import flash.display.Bitmap;

import org.flixel.FlxSprite;
import org.flixel.FlxG;

#if flash9
class ShipImgData extends BitmapData {public function new(){super(0,0);}}
class ShipImg extends Bitmap{public function new(){super(new ShipImgData());}}
#elseif iphone
class ShipImg extends Bitmap{public function new(){super(BitmapData.load("ship.png"));}}
#elseif cpp
class ShipImg extends Bitmap{public function new(){super(BitmapData.load("/Users/pmilham/Dropbox/Projects/XCode/Flixel/haxe/res/ship.png"));}}
#end

class Ship extends FlxSprite {
	var bullets:Array<Dynamic>;		//Refers to the bullets you can shoot at enemies
	var bulletIndex:Int;		//Keeps track of where in the list of bullets we are
	
	///*[Embed(source="ship.png")]*/ var ImgShip:Class<Dynamic>;	//Graphic of the player's ship
	
	//Constructor for the player - just initializing a simple sprite using a graphic.
	public function new(Bullets:Array<Dynamic>) {
		//This initializes this sprite object with the graphic of the ship and
		// positions it in the middle of the screen.
		super(Math.floor(FlxG.width/2-6), Math.floor(FlxG.height-12), ShipImg);
		bullets = Bullets;	//Save a reference to the bullets array
		bulletIndex = 0;	//Initialize our list marker to the first entry
	}
	
	//Basic game loop function again!
	public override function update():Void
	{
		//Controls!
		velocity.x = 0;				//Default velocity to zero
		if(FlxG.keys.LEFT)
			velocity.x -= 150;		//If the player is pressing left, set velocity to left 150
		if(FlxG.keys.RIGHT)	
			velocity.x += 150;		//If the player is pressing right, then right 150
		
		//Just like in PlayState, this is easy to forget but very important!
		//Call this to automatically evaluate your velocity and position and stuff.
		super.update();
		
		//Here we are stopping the player from moving off the screen,
		// with a little border or margin of 4 pixels.
		if(x > FlxG.width-width-4)
			x = FlxG.width-width-4; //Checking and setting the right side boundary
		if(x < 4)
			x = 4;					//Checking and setting the left side boundary
		
		//Finally, we gotta shoot some bullets amirite?  First we check to see if the
		// space bar was just pressed (no autofire in space invaders you guys)
		if(FlxG.keys.justPressed("SPACE"))
		{
			//Space bar was pressed!  FIRE A BULLET
			var b:FlxSprite = bullets[bulletIndex];	//Figure out which bullet to fire
			b.reset(x + width / 2 - b.width, y);
			b.velocity.y = -240;					//Set the vertical speed to shoot up fast
			bulletIndex++;							//Increment our bullet list tracker
			if(bulletIndex >= bullets.length)		//And check to see if we went over
				bulletIndex = 0;					//If we did just reset.
		}
	}
}
