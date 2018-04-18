package net.avdw.randomizer;
import haxe.Json;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.text.TextFormat;

/**
 * ...
 * @author Andrew van der Westhuizen
 */
class Menu extends Sprite
{
	var btns:Array<Sprite> = new Array();

	public function new()
	{
		super();

		btns.push(new Button("big-talk.json", function(e:MouseEvent):Void
		{
			addChild(new MessageView(Main.bigTalk));
		}));
		btns.push(new Button("ice-breaker.json", function(e:MouseEvent):Void
		{
			addChild(new MessageView(Main.iceBreaker));
		}));
		btns.push(new Button("koans.json", function(e:MouseEvent):Void
		{
			addChild(new MessageView(Main.koans));
		}));

		
		for (btn in btns)
		{	
			addChild(btn);
			
			btn.y = btn.height * getChildIndex(btn);
		}

		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e:Event):Void
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);

	}

}