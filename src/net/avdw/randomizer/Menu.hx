package net.avdw.randomizer;
import haxe.Json;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Andrew van der Westhuizen
 */
class Menu extends Sprite
{
	var btns:Array<Sprite> = new Array();
	var bigTalk:Array<Dynamic>;
	var iceBreaker:Array<Dynamic>;
	var koans:Array<Dynamic>;
	var main:Main;

	public function new()
	{
		super();

		bigTalk = Json.parse(Assets.getText("json/big-talk.json"));
		iceBreaker = Json.parse(Assets.getText("json/ice-breaker.json"));
		koans = Json.parse(Assets.getText("json/koans.json"));

		btns.push(new Button("Big-talks", function(e:MouseEvent):Void
		{
			main.display(new MessageView(bigTalk));
		}));
		btns.push(new Button("Ice-breakers", function(e:MouseEvent):Void
		{
			main.display(new MessageView(iceBreaker));
		}));
		btns.push(new Button("Koans", function(e:MouseEvent):Void
		{
			main.display(new MessageView(koans));
		}));

		for (btn in btns)
		{
			addChild(btn);
		}

		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e:Event):Void
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);

		main = cast (parent, Main);
		
		for (btn in btns)
		{
			btn.x = (stage.stageWidth - btn.width) / 2;
			btn.y = (btn.height + 5) * getChildIndex(btn);
			btn.y += (stage.stageHeight - (btn.height + 5) * btns.length) / 2;
		}
	}

}