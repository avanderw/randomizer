package net.avdw.randomizer;
import flash.display.Sprite;
import flash.events.MouseEvent;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;

/**
 * ...
 * @author Andrew van der Westhuizen
 */
class Button extends Sprite
{
	public function new(txt:String, handler:Dynamic->Void) 
	{
		super();
		
		var tf:TextField = new TextField();
		tf.autoSize = TextFieldAutoSize.LEFT;
		tf.text = txt;
		addChild(tf);
		
		graphics.lineStyle(1);
		graphics.beginFill(0xdddddd);
		graphics.drawRoundRect(0, 0, tf.width, tf.height, 5);
		graphics.endFill();
		
		addEventListener(MouseEvent.CLICK, handler);
	}
	
}