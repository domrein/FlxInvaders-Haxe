import org.flixel.FlxSprite;
import org.flixel.FlxU;
import org.flixel.FlxG;

import flash.display.BitmapData;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.net.URLRequest;
import flash.display.Loader;
	
#if flash9
class AlienImgData extends BitmapData {public function new(){super(0,0);}}
class AlienImg extends Bitmap{public function new(){super(new AlienImgData());}}
#elseif iphone
class AlienImg extends Bitmap{public function new(){super(BitmapData.load("tempAlienSmall.png"));}}
#elseif cpp
class AlienImg extends Bitmap{public function new(){super(BitmapData.load("/Users/pmilham/Dropbox/Projects/XCode/Flixel/haxe/res/tempAlienSmall.png"));}}
#end

class Alien extends FlxSprite {
	var bullets:Array<Dynamic>;			//Reference to the bullets the enemies shoot at you
	static var bulletIndex:Int;	//Tracker or marker for the bullet list
	var shotClock:Float;			//A simple timer for deciding when to shoot
	var originalX:Int;				//Saves the starting horizontal position (for movement logic)
	
	///*[Embed(source="alien.png")]*/ var ImgAlien:Class<Dynamic>;	//The graphic of the squid monster
	
	//This is the constructor for the squid monster.
	//We are going to set up the basic values and then create a simple animation.
	public function new(X:Int, Y:Int, Color:Int, Bullets:Array<Dynamic>) {
		super(X,Y);					//Initialize sprite object

		//forAlien = true;
		loadGraphic(AlienImg,true);	//Load this animated graphic file
		
		//Saving off some of the values we passed in
		originalX = X;
		color = Color;		//setting the color tints the plain white alien graphic
		bullets = Bullets;
		bulletIndex = 0;
		restart();			//Resets the timer for the bullet shooting logic
		
		//Time to create a simple animation!  alien.png has 3 frames of animation in it.
		//We want to play them in the order 1, 2, 3, 1 (but of course this stuff is 0-index).
		//To avoid a weird, annoying appearance the framerate is randomized a little bit
		// to a value between 6 and 10 (6+4) frames per second.
		addAnimation("Default",[0,1,0,2],Math.floor(6+FlxU.random()*4));
		
		//Now that the animation is set up, it's very easy to play it back!
		play("Default");
		
		//Everybody move to the right!
		velocity.x = 10;
	}
	
	//Basic game loop is BACK y'all
	public override function update():Void
	{
		//If alien has moved too far to the left, reverse direction and increase speed!
		if(x < originalX - 8)
		{
			x = originalX - 8;
			velocity.x = 10;
			velocity.y++;
		}
		if(x > originalX + 8) //If alien has moved too far to the right, reverse direction
		{
			x = originalX + 8;
			velocity.x = -10;
		}
		
		//Then do some bullet shooting logic
		if(y > FlxG.height * 0.35)
			shotClock -= FlxG.elapsed; //Only count down if on the bottom half of the screen
		if(shotClock <= 0)
		{
			//We counted down to zero, so it's time to shoot a bullet!
			restart();									//First, reset the shot clock
			var b:FlxSprite = bullets[bulletIndex];		//Then look up the bullet
			b.reset(x + width / 2 - b.width, y);
			b.velocity.y = 65;
			bulletIndex++;
			if(bulletIndex >= bullets.length)
				bulletIndex = 0;
		}
		
		//Finally, the all important basic game loop update
		super.update();
	}
	
	//This function just resets our bullet logic timer to a random value between 1 and 11
	function restart():Void
	{
		shotClock = 1+FlxU.random()*10;
	}
}
