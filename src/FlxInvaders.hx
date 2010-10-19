import org.flixel.FlxGame; //Allows you to refer to flixel objects in your code
import flash.text.TextField;
//[Frame(factoryClass="Preloader")]  //Tells flixel to use the default preloader

//class AlienImgData extends BitmapData {public function new(){super(0,0);}}
//class AlienImg extends Bitmap{public function new(){super(new AlienImgData());}}

class FlxInvaders extends FlxGame {
	public function new() {
		super(160,240,PlayState); //Create a new FlxGame object at 320x240 with 2x pixels, then load PlayState
		//showLogo = false;
	}
}
