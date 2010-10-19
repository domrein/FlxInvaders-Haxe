package ;

import flash.Lib;
import flash.text.TextField;
import flash.display.FPS;

/**
 * ...
 * @author Paul Milham
 */

class Main 
{
	public static var debugTextField:TextField;
	
	public function new() {
		debugTextField = new TextField();
		debugTextField.width = 320;
		debugTextField.height = 480;
		debugTextField.text = "";
		debugTextField.textColor = 0xFFFFFF;
		flash.Lib.current.addChild(debugTextField);
		
		flash.Lib.current.addChild(new FlxInvaders());
		flash.Lib.current.addChild(new FPS(5, 5, 0xFFFFFF));
	}
	
	public static function main() 
	{
		#if iphone
		new Main();
		#elseif cpp
		Lib.create(function(){new Main();},320,480,60,0xccccff,(1*Lib.HARDWARE) | Lib.RESIZABLE);
		#end
	}
}